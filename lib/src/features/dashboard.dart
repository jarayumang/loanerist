import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      endDrawer: const Drawer(),
      backgroundColor: ColorConstants.darkWhite,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,',
              style: TextStyle(fontFamily: 'GilroySemiBold'),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${loggedInUser.name}'.toUpperCase(),
              style: const TextStyle(fontFamily: 'GilroyBlack', fontSize: 25),
            )
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: Icon(
                  Icons.notifications_rounded,
                  color: ColorConstants.appBlue,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        titleTextStyle: TextStyle(color: ColorConstants.appBlue),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
            color: ColorConstants.darkWhite,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 20,
                    percent: 0.7,
                    progressColor: ColorConstants.appBlue,
                    backgroundColor: Colors.transparent,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('P41,000',
                            style: TextStyle(
                              fontFamily: 'GilroyBold',
                              fontSize: 30,
                            )),
                        Text('25 May, 2023',
                            style: TextStyle(
                              fontFamily: 'GilroySemiBold',
                              fontSize: 15,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'P10,000',
                            style: TextStyle(
                                fontSize: 25, fontFamily: 'GilroyBold'),
                          ),
                          Text(
                            'Groceries',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'GilroyBold'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'P20,000',
                            style: TextStyle(
                                fontSize: 25, fontFamily: 'GilroyBold'),
                          ),
                          Text(
                            'Loans',
                            style: TextStyle(
                                fontSize: 15, fontFamily: 'GilroySemiBold'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Text('Second')
        ],
      ),
    );
  }
}
