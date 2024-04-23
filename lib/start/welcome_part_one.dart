import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/start/welcome_part_two.dart';

class WelcomeOne extends StatelessWidget {
  const WelcomeOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.welcomeBackgroundColor,
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome!',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: ColorConstants.blackColor
                      )
                    )),
                Image.asset(
                  'assets/images/welcome_image.jpg',
                  height: 300,
                  width: 300,
                ),
                SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(BorderSide(color: ColorConstants.blueAccentColor)), // Border color
                      backgroundColor: MaterialStateProperty.all<Color>(ColorConstants.blueAccentColor), // Background color
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
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
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => WelcomeTwo()));
                    },
                    child: Text('Get Started',
                        style: TextStyle(
                            color: ColorConstants.blackColor,
                            fontFamily: 'NoirPro',
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
