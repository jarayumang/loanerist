import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/pages/loans.dart';
import 'package:loanerist/pages/profile.dart';
import 'package:loanerist/pages/schedule.dart';
import 'package:loanerist/pages/wallet.dart';
import 'package:toastification/toastification.dart';

import '../constants/comma.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Stream<DocumentSnapshot> userDataStream;
  late Stream<QuerySnapshot> userLoansStream;

  @override
  void initState() {
    super.initState();
    userDataStream = getUserDataStream();
    userLoansStream = getUserLoansStream();
  }

  Stream<DocumentSnapshot> getUserDataStream() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('user_info')
        .doc(user?.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getUserLoansStream() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('user_info/${user?.uid}/loans')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 45,
              width: 45,
            ),
          ],
        ),
        backgroundColor: ColorConstants.whiteColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        color: ColorConstants.whiteColor,
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: userDataStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return const Text('No user data found');
                }

                Map<String, dynamic>? userData =
                    snapshot.data?.data() as Map<String, dynamic>?;

                if (userData == null) {
                  return const Text('No user data found');
                }

                return buildBalanceWidget(userData);
              },
            ),
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: userLoansStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData) {
                  return Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Latest Loan Dues',
                                style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontFamily: 'NoirPro',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800)),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.only(top: 10.0),
                                children: [
                                  Text('No loans found'),
                                ],
                              ),
                            )
                          ]));
                }

                List<DocumentSnapshot> loanDocs = snapshot.data!.docs;
                if (loanDocs.isEmpty) {
                  return Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Latest Loan Dues',
                                style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontFamily: 'NoirPro',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800)),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.only(top: 10.0),
                                children: [
                                  Text('No loans found'),
                                ],
                              ),
                            )
                          ]));
                }

                return buildLatestLoanDuesWidget(loanDocs);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBalanceWidget(Map<String, dynamic> userData) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorConstants.blueAccentColor,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your current balance:',
                      style: TextStyle(
                        color: ColorConstants.blackColor,
                        fontFamily: 'NoirPro',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                            formatNumberWithCommas(userData['current_balance']),
                            style: TextStyle(
                                fontFamily: 'NoirPro',
                                color: ColorConstants.blackColor,
                                fontSize: 35,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5)),
                      ),
                      Text('PHP',
                          style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: 'NoirPro',
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          )),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(9, 4, 9, 2),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            width: 1, color: ColorConstants.blackColor)),
                    child:
                        Text('PHP ${userData['left_balance']} left in budget',
                            style: TextStyle(
                              color: ColorConstants.blackColor,
                              fontFamily: 'NoirPro',
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            )),
                  ),
                ])),
        SizedBox(
          height: 145,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 20.0),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Wallet()));
                  },
                  child: Container(
                    width: 130,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteAccentColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 1, color: ColorConstants.whiteAccentColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.wallet,
                          color: ColorConstants.blackColor,
                          size: 25,
                        ),
                        Text('My Budget',
                            style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontFamily: 'NoirPro',
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Loans()));
                  },
                  child: Container(
                    width: 130,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteAccentColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 1, color: ColorConstants.whiteAccentColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.moneyBill,
                          color: ColorConstants.blackColor,
                          size: 25,
                        ),
                        Text('Loans',
                            style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontFamily: 'NoirPro',
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Schedule()));
                  },
                  child: Container(
                    width: 130,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteAccentColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 1, color: ColorConstants.whiteAccentColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidCalendar,
                          color: ColorConstants.blackColor,
                          size: 25,
                        ),
                        Text('Schedule',
                            style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontFamily: 'NoirPro',
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()));
                  },
                  child: Container(
                    width: 130,
                    height: 100,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: ColorConstants.whiteAccentColor,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                            width: 1, color: ColorConstants.whiteAccentColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.gear,
                          color: ColorConstants.blackColor,
                          size: 25,
                        ),
                        Text('Settings',
                            style: TextStyle(
                                color: ColorConstants.blackColor,
                                fontFamily: 'NoirPro',
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLatestLoanDuesWidget(List<DocumentSnapshot> loanDocs) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Latest Loan Dues',
              style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontFamily: 'NoirPro',
                  fontSize: 15,
                  fontWeight: FontWeight.w800)),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.only(top: 10.0),
                children: loanDocs.map((loan) {
                  return Column(
                    children: [
                      Container(
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
                                Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: ColorConstants.whiteColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              ColorConstants.blueAccentColor)),
                                  child: Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.solidCreditCard,
                                      color: ColorConstants.blueAccentColor,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(loan['loan_name'],
                                        style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontFamily: 'NoirPro',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800)),
                                    Text(loan['end_date'],
                                        style: TextStyle(
                                            color: ColorConstants.blackColor,
                                            fontFamily: 'NoirPro',
                                            fontSize: 10,
                                            fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ],
                            ),
                            Text('${loan['loan_monthly_amount']} PHP',
                                style: TextStyle(
                                    color: ColorConstants.blackColor,
                                    fontFamily: 'NoirPro',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
