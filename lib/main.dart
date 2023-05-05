import 'package:flutter/material.dart';
import 'package:loanerist/src/constants/color.dart';
import 'package:loanerist/src/features/bill.dart';
import 'package:loanerist/src/features/dashboard.dart';
import 'package:loanerist/src/features/loan.dart';
import 'package:loanerist/src/features/setting.dart';

void main() async {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedScreenIndex = 0;

  final List _screens = [
    {"screen": const Dashboard(), "title": "Dashboard"},
    {"screen": const Loan(), "title": "Loans"},
    {"screen": const Bill(), "title": "Bills"},
    {"screen": const Setting(), "title": "Settings"}
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: Scaffold(
        body: _screens[_selectedScreenIndex]["screen"],
        bottomNavigationBar: Container(
          height: 70,
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: ColorConstants.appBlue,
            unselectedItemColor: ColorConstants.lightBlack,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedScreenIndex,
            onTap: _selectScreen,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wallet_rounded), label: "Wallet"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.payments_rounded), label: "Loans"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded), label: "Settings")
            ],
          ),
        ),
      ),
    );
  }
}
