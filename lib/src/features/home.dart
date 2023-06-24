import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/src/constants/color.dart';
import 'package:loanerist/src/features/bill.dart';
import 'package:loanerist/src/features/dashboard.dart';
import 'package:loanerist/src/features/loan.dart';
import 'package:loanerist/src/features/setting.dart';

import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedScreenIndex = 0;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  final List<Map<String, dynamic>> _screens = [
    {"screen": const Dashboard(), "title": "Dashboard"},
    {"screen": const Bill(), "title": "Bills"},
    {"screen": const Loan(), "title": "Loans"},
    {"screen": const Setting(), "title": "Settings"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data() as Map<String, dynamic>);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlack,
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: Stack(
        children: [
          SizedBox(
            height: 60,
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: ColorConstants.appBlue,
              unselectedItemColor: ColorConstants.darkWhite,
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedScreenIndex,
              onTap: _selectScreen,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.payments_rounded),
                  label: "Loans",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_rounded),
                  label: "Wallet",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded),
                  label: "Settings",
                ),
              ],
            ),
          ),
          Positioned(
            left: (_selectedScreenIndex * (MediaQuery.of(context).size.width / _screens.length)) +
                ((MediaQuery.of(context).size.width / _screens.length) - 25) / 2,
            bottom: 0,
            child: Container(
              height: 3,
              width: 25,
              decoration: BoxDecoration(
                color: ColorConstants.appBlue, // Adjust the color as needed
                borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
              ), // Adjust the color as needed
            ),
          ),
        ],
      ),
    );
  }
}
