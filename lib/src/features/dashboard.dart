import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/src/common/monthly_report_card.dart';
import 'package:loanerist/src/constants/page_style.dart';
import 'package:loanerist/src/features/add_report.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants/color.dart';
import '../models/user_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.lightBlack,
        appBar: AppBar(
          title: Text(
            'Hello, ${loggedInUser.name}',
            style: const TextStyle(fontFamily: 'GilroyBold', fontSize: 20),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddReport(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add_rounded,
                    color: ColorConstants.darkWhite,
                  )),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60,
          titleTextStyle: TextStyle(color: ColorConstants.darkWhite),
        ),
        body: Container(
            padding: pagePadding,
            // color: Colors.red,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    child: GridView.count(
                      childAspectRatio: (1 / 0.65),
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      // Number of columns in the grid
                      crossAxisSpacing: 20,
                      // Spacing between columns
                      mainAxisSpacing: 20,
                      children: [
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.red),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .white, // Customize the background color as needed
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      // Adjust the padding as desired
                                      child: Icon(
                                        Icons.account_balance_wallet_rounded,
                                        size: 30,
                                        // Adjust the size of the icon as desired
                                        color: Colors
                                            .red, // Customize the icon color as needed
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          '8',
                                          style: TextStyle(
                                              fontFamily: 'GilroyBold',
                                              fontSize: 20),
                                        ),
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                              fontFamily: 'GilroyBold',
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.blue),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .white, // Customize the background color as needed
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    // Adjust the padding as desired
                                    child: Icon(
                                      Icons.savings_rounded,
                                      size: 30,
                                      // Adjust the size of the icon as desired
                                      color: Colors
                                          .blue, // Customize the icon color as needed
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'Savings',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 0.8,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.yellow),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .white, // Customize the background color as needed
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    // Adjust the padding as desired
                                    child: Icon(
                                      Icons.subscriptions_rounded,
                                      size: 30,
                                      // Adjust the size of the icon as desired
                                      color: Colors
                                          .orange, // Customize the icon color as needed
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'Subs',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 1.2,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.green),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors
                                          .white, // Customize the background color as needed
                                    ),
                                    padding: EdgeInsets.all(8.0),
                                    // Adjust the padding as desired
                                    child: Icon(
                                      Icons.folder_off_rounded,
                                      size: 30,
                                      // Adjust the size of the icon as desired
                                      color: Colors
                                          .green, // Customize the icon color as needed
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '8',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 20),
                                      ),
                                      Text(
                                        'Unpaid',
                                        style: TextStyle(
                                            fontFamily: 'GilroyBold',
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height - 100) / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Text(
                            'Monthly Reports',
                            style: TextStyle(
                                fontFamily: 'GilroyBold',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Monthly_Report_Card(),
                                Monthly_Report_Card(),
                                Monthly_Report_Card(),
                                Monthly_Report_Card(),
                                Monthly_Report_Card(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
