import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/pages/loans/view_loans.dart';
import 'package:loanerist/constants/comma.dart';
import 'package:loanerist/pages/loans/add_loans.dart';

class Loans extends StatefulWidget {
  const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  late Stream<List<dynamic>> loansStream;
  var loansList = [];

  @override
  void initState() {
    super.initState();
    loansStream = fetchLoansStream();
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
          title: Text('Loans',
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
                      return const AddLoanModal();
                    },
                  );

                  await fetchLoans();
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
            stream: loansStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show loading indicator while data is being fetched
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              // If there's no error and data is available, display it
              List<dynamic> loansList = snapshot.data ?? [];
              return ListView(
                  padding: const EdgeInsets.only(top: 10.0),
                  children: loansList.map((loan) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              // isScrollControlled: true,
                              builder: (BuildContext context) {
                                return ViewLoanModal(loan['id']);
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
                                        Text(loan['loan_name'],
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
                                            'PHP ${formatNumberWithCommas(loan['loan_amount'])}',
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
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                        '${formatNumberWithCommas(loan['loan_monthly_amount'])} PHP',
                                        style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontFamily: 'NoirPro',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800)),
                                    Text(loan['loan_monthly_payment'],
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

  Stream<List<dynamic>> fetchLoansStream() {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference loans =
        FirebaseFirestore.instance.collection('user_info/${user?.uid}/loans');

    // Create a StreamController to handle merging streams
    StreamController<List<dynamic>> controller =
        StreamController<List<dynamic>>();

    // Listen to changes in the Firestore collection
    loans.snapshots().listen((QuerySnapshot querySnapshot) {
      List<Map<String, dynamic>> loanList = [];
      for (var doc in querySnapshot.docs) {
        String documentId = doc.id;
        Map<String, dynamic>? loanData = doc.data() as Map<String, dynamic>?;
        if (loanData != null && loanData['is_active'] == true) {
          loanList.add({'id': documentId, ...loanData});
        }
      }
      controller.add(loanList);
    });

    // Listen for changes in a specific document (new loan added)
    loans.doc().snapshots().listen((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic>? newLoanData =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (newLoanData != null && newLoanData['is_active'] == true) {
        controller.add([
          {'id': documentSnapshot.id, ...newLoanData}
        ]);
      }
    });

    return controller.stream;
  }
}

Future<List<dynamic>> fetchLoans() async {
  var loanActive = [];
  var loanInactive = [];

  try {
    User? user = FirebaseAuth.instance.currentUser;

    CollectionReference loans =
        FirebaseFirestore.instance.collection('user_info/${user?.uid}/loans');

    QuerySnapshot userLoansSnapshot = await loans.get();

    for (var doc in userLoansSnapshot.docs) {
      String documentId = doc.id;
      Map<String, dynamic>? loanData = doc.data() as Map<String, dynamic>?;

      if (loanData != null && loanData['is_active'] == true) {
        loanActive.add({'id': documentId, ...loanData});
      } else {
        loanInactive.add({'id': documentId, ...?loanData});
      }
    }

    return loanActive;
    } catch (e) {
      print('Error: $e');
  }

  // Return an empty list if there's an error or no loans found
  return [];
}
