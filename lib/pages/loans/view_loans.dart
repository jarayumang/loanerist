import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/comma.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/pages/loans/delete_loans.dart';
import 'package:loanerist/pages/loans/edit_loans.dart';

class ViewLoanModal extends StatefulWidget {
  final String loan;

  const ViewLoanModal(this.loan, {super.key});

  @override
  ViewLoanModalState createState() => ViewLoanModalState();
}

class ViewLoanModalState extends State<ViewLoanModal> {
  late Stream<DocumentSnapshot> loanStream;

  @override
  void initState() {
    super.initState();
    loanStream = FirebaseFirestore.instance
        .doc(
            'user_info/${FirebaseAuth.instance.currentUser?.uid}/loans/${widget.loan}')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: loanStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          Map<String, dynamic>? loanDetails =
              snapshot.data?.data() as Map<String, dynamic>?;

          if (loanDetails == null) {
            return const Text('Loan not found');
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
                          Text('Loan Name',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(loanDetails['loan_name'] ?? 'Loan Name',
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loan Amount',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              formatNumberWithCommas(
                                      loanDetails['loan_amount'] ?? 0),
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
                          Text('Loan Date',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              loanDetails['loan_monthly_payment'] ??
                                  'Loan Monthly Payment',
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loan Count',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              formatNumberWithCommas(
                                      loanDetails['loan_count'] ?? 0),
                              style: GoogleFonts.prozaLibre(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loan Amount',
                              style: GoogleFonts.cormorantGaramond(
                                  color: ColorConstants.textBlackColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 5),
                          Text(
                              formatNumberWithCommas(
                                      loanDetails['loan_monthly_amount'] ??
                                          0),
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
                        width: 150,
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
                                  return EditLoans(loanDetails: {'id': widget.loan, ...loanDetails});
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
                                Text('Edit Loan',
                                    style: GoogleFonts.prozaLibre(
                                        color: ColorConstants.textAccentColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 170,
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
                                  return buildAlertDialog(
                                      context, widget.loan);
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
                                Text('Delete Loan',
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
}
