import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/constants/comma.dart';
import 'package:loanerist/pages/budget/add_budget.dart';
import 'package:loanerist/pages/loans/add_loans.dart';

import 'budget/view_budget.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late Stream<List<dynamic>> budgetStream;

  @override
  void initState() {
    super.initState();
    budgetStream = fetchBudgetStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(
            padding: const EdgeInsets.only(left: 15.0),
            height: 45,
            width: 45,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: FaIcon(
                FontAwesomeIcons.squareCaretLeft,
                color: ColorConstants.blackColor,
                size: 25,
              ),
            ),
          ),
          leadingWidth: 71,
          title: Text('My Budget',
              style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontFamily: 'NoirPro',
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          centerTitle: true,
          backgroundColor: ColorConstants.whiteColor,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    // isScrollControlled: true,
                    builder: (BuildContext context) {
                      return const AddBudgetModal();
                    },
                  );
                },
                icon: FaIcon(
                  FontAwesomeIcons.squarePlus,
                  color: ColorConstants.blackColor,
                  size: 25,
                ),
              ),
            ),
          ]),
      body: Container(
          padding: const EdgeInsets.all(15.0),
          width: double.infinity,
          color: ColorConstants.whiteColor,
          child: StreamBuilder<List<dynamic>>(
            stream: budgetStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // If there's no error and data is available, display it
              List<dynamic> budgetList = snapshot.data ?? [];
              print(budgetList);
              return ListView(
                  padding: const EdgeInsets.only(top: 10.0),
                  children: budgetList.map((budget) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              // isScrollControlled: true,
                              builder: (BuildContext context) {
                                return ViewBudgetModal(budget['id']);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: ColorConstants.whiteAccentColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: ColorConstants.whiteAccentColor)),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(budget['name'],
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.blackColor,
                                                fontFamily: 'NoirPro',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'PHP ${formatNumberWithCommas(budget['amount'])}',
                                            style: TextStyle(
                                                color:
                                                    ColorConstants.blackColor,
                                                fontFamily: 'NoirPro',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800)),
                                      ],
                                    ),
                                  ],
                                ),
                                budgetCount(budget['is_recurring'],
                                    budget?['budget_count']),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // padding: EdgeInsets.fromLTRB(10, 5, 10, 5 ),
                                      width: 80,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        // shape: BoxShape.circle,
                                        color: ColorConstants.blueAccentColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          budget['is_recurring']
                                              ? 'Recurring'
                                              : 'Fixed', // Display 'Recurring' if is_recurring is true
                                          style: TextStyle(
                                            color: ColorConstants
                                                .whiteColor, // Change text color according to your design
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(budget['recurring_date'],
                                        style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontFamily: 'NoirPro',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }).toList());
            },
          )),
    );
  }

  Stream<List<dynamic>> fetchBudgetStream() {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference budget =
        FirebaseFirestore.instance.collection('user_info/${user?.uid}/budget');

    StreamController<List<dynamic>> controller =
        StreamController<List<dynamic>>();

    budget.snapshots().listen((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> budgetList = [];
      for (var doc in querySnapshot.docs) {
        String documentId = doc.id;
        Map<String, dynamic>? budgetData = doc.data() as Map<String, dynamic>?;
        if (budgetData != null && budgetData['is_active'] == true) {
          budgetList.add({'id': documentId, ...budgetData});
        }
      }
      controller.add(budgetList);
    });

    // Listen for changes in a specific document (new loan added)
    budget.doc().snapshots().listen((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic>? newBudgetData =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (newBudgetData != null && newBudgetData['is_active'] == true) {
        controller.add([
          {'id': documentSnapshot.id, ...newBudgetData}
        ]);
      }
    });

    return controller.stream;
  }
}

Container budgetCount(bool recurring, budgetCount) {
  if (!recurring) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Count',
            style: GoogleFonts.cormorantGaramond(
              color: ColorConstants.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10),
          Text(
            formatNumberWithCommas(budgetCount ?? 0),
            style: GoogleFonts.prozaLibre(
              color: ColorConstants.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  } else {
    return Container();
  }
}
