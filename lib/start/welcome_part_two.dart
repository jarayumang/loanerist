import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/colors.dart';

class WelcomeTwo extends StatefulWidget {
  const WelcomeTwo({Key? key}) : super(key: key);

  @override
  State<WelcomeTwo> createState() => _WelcomeTwoState();
}

class _WelcomeTwoState extends State<WelcomeTwo> {
  int activeStep = 0;

  bool _fullNameController = false;
  bool _mobileController = false;

  PageController _pageController = PageController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Stepper Demo',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                EasyStepper(
                  activeStep: activeStep,
                  lineStyle: LineStyle(
                    defaultLineColor: ColorConstants.blueAccentColor,
                    lineLength: 50,
                    lineType: LineType.normal,
                    lineThickness: 3,
                    lineSpace: 1,
                    lineWidth: 10,
                    unreachedLineType: LineType.dashed,
                  ),
                  stepShape: StepShape.circle,
                  stepBorderRadius: 15,
                  borderThickness: 2,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  stepRadius: 28,
                  activeStepTextColor: ColorConstants.blueAccentColor,
                  activeStepBorderColor: ColorConstants.blueAccentColor,
                  unreachedStepBorderColor: ColorConstants.blueAccentColor,
                  finishedStepBorderColor: ColorConstants.blueAccentColor,
                  finishedStepTextColor: ColorConstants.blueAccentColor,
                  finishedStepBackgroundColor: ColorConstants.blueAccentColor,
                  activeStepIconColor: ColorConstants.textBlackColor,
                  showLoadingAnimation: false,
                  steps: [
                    EasyStep(
                      icon: Icon(FaIcon(FontAwesomeIcons.user).icon),
                    ),
                    EasyStep(
                      icon: Icon(FaIcon(FontAwesomeIcons.moneyBill).icon),
                    ),
                    EasyStep(
                      icon: Icon(FaIcon(FontAwesomeIcons.gear).icon),
                    ),
                  ],
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 400, // Adjust the height of the PageView
                  child: PageView(
                    controller: _pageController,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable swipe gesture
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text('Set up your profile',
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.blackColor))),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: fullNameController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    errorText: _fullNameController
                                        ? "Full Name can't be empty"
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD86951),
                                            width: 1)),
                                    labelText: "Full Name",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: mobileController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    errorText: _fullNameController
                                        ? "Mobile Number can't be empty"
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD86951),
                                            width: 1)),
                                    labelText: "Mobile Number",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: genderController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    labelText: "Gender",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: birthdayController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    labelText: "Birthday",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                          color: ColorConstants
                                              .blueAccentColor)), // Border color
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(ColorConstants
                                          .blueAccentColor), // Background color
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white), // Text color
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  mouseCursor:
                                      MaterialStateProperty.all<MouseCursor>(
                                    MaterialStateMouseCursor.clickable,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _fullNameController =
                                        fullNameController.text.isEmpty;
                                    _mobileController =
                                        mobileController.text.isEmpty;

                                    if (activeStep < 2) {
                                      activeStep++;
                                      _pageController.animateToPage(activeStep,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                    }
                                  });
                                },
                                child: Text('Next Step',
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.blackColor))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Text('Set up your money',
                                style: GoogleFonts.openSans(
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.blackColor))),
                            SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: fullNameController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    errorText: _fullNameController
                                        ? "Full Name can't be empty"
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD86951),
                                            width: 1)),
                                    labelText: "Full Name",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: mobileController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    errorText: _fullNameController
                                        ? "Mobile Number can't be empty"
                                        : null,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFFD86951),
                                            width: 1)),
                                    labelText: "Mobile Number",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: genderController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    labelText: "Gender",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 50,
                              child: TextField(
                                style: const TextStyle(fontSize: 13),
                                controller: birthdayController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF76ABAE),
                                            width: 1)),
                                    labelText: "Birthday",
                                    labelStyle: const TextStyle(
                                        color: Color(0xFFb2b7bf),
                                        fontSize: 13.0)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                          color: ColorConstants
                                              .blueAccentColor)), // Border color
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(ColorConstants
                                          .blueAccentColor), // Background color
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white), // Text color
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  mouseCursor:
                                      MaterialStateProperty.all<MouseCursor>(
                                    MaterialStateMouseCursor.clickable,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _fullNameController =
                                        fullNameController.text.isEmpty;
                                    _mobileController =
                                        mobileController.text.isEmpty;

                                    if (activeStep < 2) {
                                      activeStep++;
                                      _pageController.animateToPage(activeStep,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                    }
                                  });
                                },
                                child: Text('Next Step',
                                    style: GoogleFonts.openSans(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstants.blackColor))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        child: Center(
                          child: Text('Settings Page'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
