import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:loanerist/src/constants/color.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);
  static const keyDarkMode = 'key-dark-mode';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SwitchSettingsTile(
              title: 'Dark Mode',
              leading: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: ColorConstants.green,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Icon(
                    Icons.dark_mode_rounded,
                    color: ColorConstants.darkWhite,
                    size: 20,
                  )),
              settingKey: keyDarkMode,
              onChange: (_) {},
            ),
            const SizedBox(
              height: 10,
            ),
            SettingsGroup(
              title: 'General',
              titleTextStyle: TextStyle(color: ColorConstants.lightBlue),
              children: <Widget>[
                SimpleSettingsTile(
                  title: 'Language',
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
                  subtitle: '',
                  leading: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstants.appBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(
                        Icons.logout_rounded,
                        color: ColorConstants.darkWhite,
                        size: 20,
                      )),
                  // onTap: ,
                ),
                SimpleSettingsTile(
                  title: 'Delete Account',
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
                  // onTap: ,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SettingsGroup(
              title: 'Feedback',
              titleTextStyle: TextStyle(color: ColorConstants.lightBlue),
              children: <Widget>[
                SimpleSettingsTile(
                  title: 'Report Bug',
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
}
