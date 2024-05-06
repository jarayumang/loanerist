import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/pages/dashboard.dart';

enum SalaryEnum { daily, weekly, biWeekly, monthly }

class WelcomeTwo extends StatefulWidget {
  const WelcomeTwo({super.key});

  @override
  State<WelcomeTwo> createState() => _WelcomeTwoState();
}

class _WelcomeTwoState extends State<WelcomeTwo> {
  int activeStep = 0;
  SalaryEnum? selectedSalary;

  bool _fullNameController = false;
  bool _mobileController = false;
  bool _salaryController = false;
  bool _salaryDateController = false;

  PageController _pageController = PageController();
  //PROFILE CONTROLLERS
  TextEditingController fullNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  //SALARY CONTROLLERS
  TextEditingController salaryController = TextEditingController();
  TextEditingController salaryDateController = TextEditingController();
  TextEditingController salaryEnumController = TextEditingController();

  void handleOptionChanged(SalaryEnum value) {
    setState(() {
      selectedSalary = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Stepper Demo',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
                      icon: Icon(const FaIcon(FontAwesomeIcons.user).icon),
                    ),
                    EasyStep(
                      icon: Icon(const FaIcon(FontAwesomeIcons.moneyBill).icon),
                    )
                  ],
                  onStepReached: (index) {
                    setState(() {
                      if (index > activeStep) {
                        activeStep = index;
                        _pageController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      }
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 600,
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
                            welcomeTextField(fullNameController,
                                _fullNameController, "Full Name"),
                            const SizedBox(
                              height: 10,
                            ),
                            welcomeTextField(mobileController,
                                _mobileController, "Mobile Number"),
                            const SizedBox(
                              height: 10,
                            ),
                            welcomeTextField(genderController, null, "Gender"),
                            const SizedBox(
                              height: 10,
                            ),
                            welcomeTextField(
                                birthdayController, null, "Birthday"),
                            const SizedBox(
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

                                    if (activeStep < 2 &&
                                        !_fullNameController &&
                                        !_mobileController) {
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
                            const SizedBox(
                              height: 50,
                            ),
                            welcomeTextField(
                                salaryController, _salaryController, "Salary"),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 80,
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    String formattedDate =
                                        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                                    setState(() {
                                      salaryDateController.text =
                                          formattedDate; // Update the controller's text within setState
                                    });
                                  }
                                },
                                child: AbsorbPointer(
                                  child: TextField(
                                    style: const TextStyle(fontSize: 13),
                                    controller: salaryDateController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.all(20.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xFF76ABAE),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF76ABAE),
                                              width: 1)),
                                      errorText: _salaryDateController
                                          ? "Salary Date can't be empty"
                                          : null,
                                      errorBorder: (OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFD86951),
                                              width: 1))),
                                      labelText: "Salary Date",
                                      labelStyle: const TextStyle(
                                          color: Color(0xFFb2b7bf),
                                          fontSize: 13.0),
                                      suffixIcon: const Align(
                                        widthFactor: 1.0,
                                        heightFactor: 1.0,
                                        child: FaIcon(
                                          FontAwesomeIcons
                                              .calendar, // Use the desired icon
                                          color: Colors.grey,
                                          size:
                                              15, // Define the color of the icon
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 300,
                              height: 250,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RadioListTile(
                                    title: const Text('Daily'),
                                    value: SalaryEnum.daily,
                                    groupValue: selectedSalary,
                                    onChanged: (value) {
                                      handleOptionChanged(value as SalaryEnum);
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text('Weekly'),
                                    value: SalaryEnum.weekly,
                                    groupValue: selectedSalary,
                                    onChanged: (value) {
                                      handleOptionChanged(value as SalaryEnum);
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text('Bi-Weekly'),
                                    value: SalaryEnum.biWeekly,
                                    groupValue: selectedSalary,
                                    onChanged: (value) {
                                      handleOptionChanged(value as SalaryEnum);
                                    },
                                  ),
                                  RadioListTile(
                                    title: const Text('Monthly'),
                                    value: SalaryEnum.monthly,
                                    groupValue: selectedSalary,
                                    onChanged: (value) {
                                      handleOptionChanged(value as SalaryEnum);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
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
                                    addDetails(
                                      fullNameController,
                                      genderController,
                                      mobileController,
                                      birthdayController,
                                      salaryController,
                                      salaryDateController,
                                      salaryEnumController,
                                    );
                                    _salaryController =
                                        salaryController.text.isEmpty;
                                    _salaryDateController =
                                        salaryDateController.text.isEmpty;

                                    if (!_salaryController &&
                                        !_salaryDateController) {
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Dashboard(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);

                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Text("Let's Go!",
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

SizedBox welcomeTextField(controller, bool? error, label) {
  return SizedBox(
    width: 300,
    height: 80,
    child: TextField(
      style: const TextStyle(fontSize: 13),
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1),
              borderRadius: BorderRadius.circular(10)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF76ABAE), width: 1)),
          errorText:
              error != null ? (error ? "$label can't be empty" : null) : null,
          errorBorder: error != null
              ? (OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFFD86951), width: 1)))
              : null,
          labelText: label,
          labelStyle:
              const TextStyle(color: Color(0xFFb2b7bf), fontSize: 13.0)),
    ),
  );
}

Future<void> addDetails(
  TextEditingController fullNameController,
  TextEditingController genderController,
  TextEditingController? mobileController,
  TextEditingController? birthdayController,
  TextEditingController salaryController,
  TextEditingController salaryDateController,
  TextEditingController salaryEnumController,
) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userInfoRef =
          FirebaseFirestore.instance.collection('user_info');

      userInfoRef.doc(user.uid).set({
        'full_name': fullNameController.text,
        'gender': genderController.text,
        'mobile': mobileController?.text ?? '',
        'birthday': birthdayController?.text ?? '',
        'current_balance': 0,
        'left_balance': 0,
        'offline_mode': false,
        'dark_mode': false,
        'salary': salaryController.text,
        'salary_date': salaryDateController.text,
        'salary_enum': salaryEnumController.text,
      });
    } else {
      print('User not signed in!');
    }
  } catch (e) {}
}
