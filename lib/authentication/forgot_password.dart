//TODO: Forgot Password Page (Should be finished April 10)
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/authentication/signup.dart';
import 'package:loanerist/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  bool _mailValidate = false;

  TextEditingController mailController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      toastification.show(
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        icon: FaIcon(
          FontAwesomeIcons.circleCheck,
          size: 20,
        ),
        title: Text('Password reset email has been sent!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        toastification.show(
          context: context,
          type: ToastificationType.warning,
          style: ToastificationStyle.flatColored,
          icon: FaIcon(
            FontAwesomeIcons.circleExclamation,
            size: 20,
          ),
          title: Text('Email not found!'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              child: Image.asset('assets/images/logo.png'),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          inputFormatters: [],
                          style: TextStyle(fontSize: 13),
                          controller: mailController,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xFF76ABAE), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFF76ABAE), width: 1)),
                              errorText:
                              _mailValidate ? "Email can't be empty" : null,
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color(0xFFD86951), width: 1)),
                              labelText: "Please enter email",
                              labelStyle: TextStyle(
                                  color: Color(0xFFb2b7bf), fontSize: 13.0)),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              _mailValidate = mailController.text.isEmpty;
                              email = mailController.text;
                            });
                          }
                          resetPassword();
                        },
                        child: Container(
                            height: 43,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: Color(0xFF76ABAE),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  "Send email",
                                  style: TextStyle(
                                      fontFamily: 'NoirPro',
                                      color: Colors.white,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                                ))),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontFamily: 'NoirPro',
                          color: Color(0xFF76ABAE),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontFamily: 'NoirPro',
                          color: Color(0xFF76ABAE),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}