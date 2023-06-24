import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/src/constants/color.dart';

import '../authentication/login.dart';
import '../constants/page_style.dart';
import '../constants/text_style.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlack,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: homeScreenHeaderTextStyle,
        ),
        titleSpacing: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Container(
        padding: pagePadding,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(color: Colors.red, child: Text('red')),
            ),
            Expanded(
              flex: 3,
              child: Container(color: Colors.blue, child: Text('red')),
            ),
            Expanded(
              flex: 1,
              child: Container(color: Colors.green, child: Text('red')),
            ),
            Expanded(
              flex: 3,
              child: Container(color: Colors.white, child: Text('red')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}

// onTap: () {
// logout(context);
// }
