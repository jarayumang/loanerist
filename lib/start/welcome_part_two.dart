import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/constants/colors.dart';

class WelcomeTwo extends StatefulWidget {
  const WelcomeTwo({Key? key}) : super(key: key);

  @override
  State<WelcomeTwo> createState() => _WelcomeTwoState();
}

class _WelcomeTwoState extends State<WelcomeTwo> {
  int activeStep = 0;
  PageController _pageController = PageController();

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
                  // internalPadding: 10,
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
                      _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 400, // Adjust the height of the PageView
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(), // Disable swipe gesture
                    children: [
                      Container(
                        color: Colors.red,
                        child: Center(
                          child: Column(
                            children: [
                              Text('Profile Page'),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (activeStep < 2) {
                                      activeStep++;
                                      _pageController.animateToPage(activeStep, duration: Duration(milliseconds: 300), curve: Curves.ease);
                                    }
                                  });
                                },
                                child: Text('Next Step'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text('Salary Page'),
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
