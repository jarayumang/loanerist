import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/pages/dashboard.dart';
import 'package:toastification/toastification.dart';
import 'package:loanerist/authentication/forgot_password.dart';
import 'package:loanerist/authentication/auth.dart';
import 'package:loanerist/authentication/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";
  bool _passwordValidate = false;
  bool _mailValidate = false;
  bool isChecked = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toastification.show(
          context: context,
          type: ToastificationType.warning,
          style: ToastificationStyle.flatColored,
          icon: const FaIcon(
            FontAwesomeIcons.circleQuestion,
            size: 20,
          ),
          title: const Text('No user found with the email.'),
          autoCloseDuration: const Duration(seconds: 5),
        );
      } else if (e.code == 'wrong-password') {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          icon: const FaIcon(
            FontAwesomeIcons.circleExclamation,
            size: 20,
          ),
          title: const Text('Incorrect password.'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(fontSize: 13),
                    controller: mailController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF76ABAE), width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFF76ABAE), width: 1)),
                        errorText:
                            _mailValidate ? "Email can't be empty" : null,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFFD86951), width: 1)),
                        labelText: "Email",
                        labelStyle: const TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 13.0)),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    style: const TextStyle(fontSize: 13),
                    controller: passwordController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF76ABAE), width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFF76ABAE), width: 1)),
                        labelText: "Password",
                        errorText: _passwordValidate
                            ? "Password can't be empty"
                            : null,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color(0xFFD86951), width: 1)),
                        labelStyle: const TextStyle(
                            color: Color(0xFFb2b7bf), fontSize: 13.0)),
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 0.5,
                            child: SizedBox(
                              height: 10,
                              width: 20,
                              child: Checkbox(
                                checkColor: Colors.white,
                                activeColor: const Color(0xFF76ABAE),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          const Text("Remember Password",
                              style: TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()));
                        },
                        child: const Text("Forgot Password?",
                              style: TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          _mailValidate = mailController.text.isEmpty;
                          _passwordValidate = passwordController.text.isEmpty;
                          email = mailController.text;
                          password = passwordController.text;
                        });
                      }
                      userLogin();
                    },
                    child: Container(
                        height: 43,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF76ABAE),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                            child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: 'NoirPro',
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600),
                        ))),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      AuthMethods().signInWithGoogle(context);
                    },
                    child: Container(
                        height: 43,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFF76ABAE),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://lh3.googleusercontent.com/COxitqgJr1sJnIDe8-jiKhxDx1FrYbtRHKJ9z_hELisAlapwE9LUPh6fcXIfb5vwpbMl4xl9H9TRFPc5NOO8Sb3VSgIBrfRYvW6cUA',
                              height: 15,
                              width: 15,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const Text(
                              "Sign In with Google",
                              style: TextStyle(
                                  fontFamily: 'NoirPro',
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(
                    fontFamily: 'NoirPro',
                    color: Color(0xFF1A1A1A),
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                width: 5.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                      fontFamily: 'NoirPro',
                      color: Color(0xFF76ABAE),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}