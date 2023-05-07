import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:loanerist/src/constants/color.dart';

import '../authentication/login.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            const SizedBox(
              height: 10,
            ),
            SettingsGroup(
              title: 'General',
              titleTextStyle: TextStyle(
                  color: ColorConstants.lightBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              children: <Widget>[
                SimpleSettingsTile(
                  title: 'Language',
                  titleTextStyle: TextStyle(
                      color: ColorConstants.lightBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  subtitle: '',
                  leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstants.green,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.translate_rounded,
                        color: ColorConstants.darkWhite,
                        size: 20,
                      )),
                  // onTap: ,
                ),
                SimpleSettingsTile(
                    title: 'Logout',
                    titleTextStyle: TextStyle(
                        color: ColorConstants.lightBlack,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    subtitle: '',
                    leading: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ColorConstants.appBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.logout_rounded,
                          color: ColorConstants.darkWhite,
                          size: 20,
                        )),
                    onTap: () {
                      logout(context);
                    }),
                SimpleSettingsTile(
                  title: 'Delete Account',
                  titleTextStyle: TextStyle(
                      color: ColorConstants.lightBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  subtitle: '',
                  leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstants.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.clear_rounded,
                        color: ColorConstants.darkWhite,
                        size: 20,
                      )),
                ),
                // onTap: ,
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SettingsGroup(
              title: 'Feedback',
              titleTextStyle: TextStyle(
                  color: ColorConstants.lightBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              children: <Widget>[
                SimpleSettingsTile(
                  title: 'Report Bug',
                  titleTextStyle: TextStyle(
                      color: ColorConstants.lightBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  subtitle: '',
                  leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstants.appBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.bug_report_rounded,
                        color: ColorConstants.darkWhite,
                        size: 20,
                      )),
                  // onTap: ,
                ),
                SimpleSettingsTile(
                  title: 'Send Feedback',
                  titleTextStyle: TextStyle(
                      color: ColorConstants.lightBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  subtitle: '',
                  leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstants.red,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.thumb_up_rounded,
                        color: ColorConstants.darkWhite,
                        size: 20,
                      )),
                  // onTap: ,
                ),
              ],
            )
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
