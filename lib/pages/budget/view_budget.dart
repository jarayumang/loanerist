import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/comma.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/pages/budget/edit_budget.dart';
import 'package:loanerist/pages/budget/delete_budget.dart';

class ViewBudgetModal extends StatefulWidget {
  final String budget;

  const ViewBudgetModal(this.budget, {super.key});

  @override
  ViewBudgetModalState createState() => ViewBudgetModalState();
}

class ViewBudgetModalState extends State<ViewBudgetModal> {
  late Stream<DocumentSnapshot> budgetStream;

  @override
  void initState() {
    super.initState();
    budgetStream = FirebaseFirestore.instance
        .doc(
        'user_info/${FirebaseAuth.instance.currentUser?.uid}/budget/${widget.budget}')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: budgetStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          Map<String, dynamic>? budgetDetails =
          snapshot.data?.data() as Map<String, dynamic>?;

          if (budgetDetails == null) {
            return const Text('Budget not found');
          }

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: ColorConstants.whiteColor,
              ),
              padding: EdgeInsets.fromLTRB(
                  20, 40, 20, MediaQuery.of(context).viewInsets.bottom + 40),
              child: Column(
                // mainAxisAlignment: ,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Budget Name',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(budgetDetails['name'] ?? '',
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Budget Amount',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              formatNumberWithCommas(
                                  budgetDetails['amount'] ?? 0),
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Recurring Date',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              budgetDetails['recurring_date'] ??
                                  '',
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      budgetViewCount(budgetDetails['is_recurring'], budgetDetails['budget_count']),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Budget Type',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(budgetDetails['is_recurring'] ? 'Recurring' : 'Fixed',
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                  width: 1,
                                  color: ColorConstants.textAccentColor)),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants
                                      .whiteColor), // Add a border here
                            ),
                            onPressed: () async {
                              await showModalBottomSheet(
                                context: context,
                                // isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return EditBudget(budgetDetails: {'id': widget.budget, ...budgetDetails});
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  color: ColorConstants.textAccentColor,
                                  size: 15,
                                ),
                                Text('Edit Budget',
                                    style: GoogleFonts.prozaLibre(
                                        color: ColorConstants.textAccentColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 180,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(BorderSide(
                                width: 1,
                                color: ColorConstants.textAccentColor,
                              )),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstants
                                      .whiteColor), // Add a border here
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildBudgetDialog(
                                      context, widget.budget);
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.trash,
                                  color: ColorConstants.textAccentColor,
                                  size: 15,
                                ),
                                Text('Delete Budget',
                                    style: GoogleFonts.prozaLibre(
                                        color: ColorConstants.textAccentColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Container budgetViewCount(bool recurring, budgetCount) {
    if (!recurring) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget Count',
                style: GoogleFonts.cormorantGaramond(
                    color: ColorConstants.textBlackColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 5),
            Text(
                formatNumberWithCommas(
                    budgetCount),
                style: GoogleFonts.prozaLibre(
                    color: ColorConstants.textBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900)),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
