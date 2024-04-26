//TODO: Settings Page (Should be finished April 10)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:toastification/toastification.dart';

import '../authentication/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Stream<DocumentSnapshot> userDataStream;

  @override
  void initState() {
    super.initState();
    userDataStream = getUserDataStream();
  }

  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to login screen or any other screen you want to navigate after logout
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LogIn()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        icon: const FaIcon(
          FontAwesomeIcons.circleExclamation,
          size: 20,
        ),
        title: Text('Error signing out: $e'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    }
  }

  Stream<DocumentSnapshot> getUserDataStream() {
    User? user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('user_info')
        .doc(user?.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.only(left: 15.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: FaIcon(
                FontAwesomeIcons.squareCaretLeft,
                color: ColorConstants.blackColor,
                size: 25,
              ),
            ),
            height: 45,
            width: 45,
          ),
          leadingWidth: 71,
          title: Text('Settings',
              style: TextStyle(
                  color: ColorConstants.blackColor,
                  fontFamily: 'NoirPro',
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          centerTitle: true,
          backgroundColor: ColorConstants.whiteColor,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          width: double.infinity,
          color: ColorConstants.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Account Information',
                          style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: 'NoirPro',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(userData,
                            FontAwesomeIcons.user, 'Full Name', 'full_name');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(userData,
                            FontAwesomeIcons.envelope, 'Email', 'email');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(userData,
                            FontAwesomeIcons.venusMars, 'Gender', 'gender');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(
                            userData,
                            FontAwesomeIcons.birthdayCake,
                            'Birthday',
                            'birthday');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(userData,
                            FontAwesomeIcons.phone, 'Change mobile', 'mobile');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Display and Security',
                          style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: 'NoirPro',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildDisplayWidget(
                            userData,
                            FontAwesomeIcons.solidMoon,
                            'Dark Mode',
                            'dark_mode');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildDisplayWidget(
                            userData,
                            FontAwesomeIcons.wifi,
                            'Offline Mode',
                            'offline_mode');
                      },
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: userDataStream,
                      builder: (context, snapshot) {
                        Map<String, dynamic> userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return buildBalanceWidget(userData,
                            FontAwesomeIcons.lock, 'Change password', 'gender');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'About',
                          style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: 'NoirPro',
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.shieldHalved,
                                color: ColorConstants.blackColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontFamily: 'NoirPro',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: ColorConstants.blackColor,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidFile,
                                color: ColorConstants.blackColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                  color: ColorConstants.blackColor,
                                  fontFamily: 'NoirPro',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: ColorConstants.blackColor,
                            size: 13,
                          ),
                        ],
                      ),
                    )
                  ])),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.red)), // Border color
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red), // Background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Text color
                    overlayColor: MaterialStateProperty.all<Color>(
                        Colors.red.withOpacity(0.1)), // Color when pressed
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    mouseCursor: MaterialStateProperty.all<MouseCursor>(
                      MaterialStateMouseCursor.clickable,
                    ),
                  ),
                  onPressed: () {
                    _logout();
                  },
                  child: Text('Sign Out',
                      style: TextStyle(
                          color: ColorConstants.whiteAccentColor,
                          fontFamily: 'NoirPro',
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
        ));
  }
}

Widget buildBalanceWidget(Map<String, dynamic> userData, icon, text, value) {
  return Container(
    height: 40,
    padding: const EdgeInsets.all(5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              color: ColorConstants.blackColor,
              size: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: ColorConstants.blackColor,
                fontFamily: 'NoirPro',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              userData[value] ?? 'Not set',
              style: TextStyle(
                color: Colors.black54,
                fontFamily: 'NoirPro',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: ColorConstants.blackColor,
              size: 13,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildDisplayWidget(Map<String, dynamic> userData, icon, text, value) {
  return Container(
    height: 40,
    padding: const EdgeInsets.all(5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              color: ColorConstants.blackColor,
              size: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: ColorConstants.blackColor,
                fontFamily: 'NoirPro',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Switch(
              value: userData[value],
              onChanged: (newValue) {
                // Handle switch state change
                // You can perform any action here, like updating the value in Firebase
              },
              activeColor: ColorConstants
                  .blueAccentColor, // Customize active color if needed
            ),
          ],
        ),
      ],
    ),
  );
}
