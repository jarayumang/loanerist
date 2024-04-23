import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loanerist/authentication/login.dart';
import 'package:loanerist/authentication/auth.dart';
import 'package:toastification/toastification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  bool _passwordValidate = false;
  bool _mailValidate = false;
  bool _nameValidate = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null &&
        nameController.text != "" &&
        mailController.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          icon: FaIcon(
            FontAwesomeIcons.circleCheck,
            size: 20,
          ),
          title: Text('Registered Successfully!'),
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flatColored,
            icon: FaIcon(
              FontAwesomeIcons.circleInfo,
              size: 20,
            ),
            title: Text('Password entered is too weak!'),
            autoCloseDuration: const Duration(seconds: 5),
          );
        } else if (e.code == "email-already-in-use") {
          toastification.show(
            context: context,
            type: ToastificationType.warning,
            style: ToastificationStyle.flatColored,
            icon: FaIcon(
              FontAwesomeIcons.circleExclamation,
              size: 20,
            ),
            title: Text('Email already registered!'),
            autoCloseDuration: const Duration(seconds: 5),
          );
        }
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
                        controller: nameController,
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
                                _nameValidate ? "Name can't be empty" : null,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xFFD86951), width: 1)),
                            labelText: "Name",
                            labelStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 13.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
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
                                _mailValidate ? "Please enter email" : null,
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: Color(0xFFD86951), width: 1)),
                            labelText: "Email",
                            labelStyle: TextStyle(
                                color: Color(0xFFb2b7bf), fontSize: 13.0)),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                        child: TextField(
                      style: TextStyle(fontSize: 13),
                      controller: passwordController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF76ABAE), width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xFF76ABAE), width: 1)),
                          labelText: "Password",
                          errorText: _passwordValidate
                              ? "Please enter password"
                              : null,
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xFFD86951), width: 1)),
                          labelStyle: TextStyle(
                              color: Color(0xFFb2b7bf), fontSize: 13.0)),
                      obscureText: true,
                    )),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _mailValidate = mailController.text.isEmpty;
                            _passwordValidate = passwordController.text.isEmpty;
                            _nameValidate = nameController.text.isEmpty;
                            email = mailController.text;
                            name = nameController.text;
                            password = passwordController.text;
                          });
                        }
                        registration();
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
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: 'NoirPro',
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600),
                          ))),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        AuthMethods().signInWithGoogle(context);
                      },
                      child: Container(
                          height: 43,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFF76ABAE),
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
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Sign Up with Google",
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
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      fontFamily: 'NoirPro',
                      color: Color(0xFF1A1A1A),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 5.0,
                ),
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
