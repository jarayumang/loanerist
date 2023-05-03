import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanerist/register.dart';

import 'auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final bool _isLogin = true; //false = register, true=login
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonDisabled = _emailController.text.isEmpty;
      _isButtonDisabled = _passwordController.text.isEmpty;
    });
  }

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    setState(() => _loading = true);

    await Auth().signInWithEmailAndPassword(email, password);

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Loanerist",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Manage your finances wisely",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your email address",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      hintStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      hintText: 'john.doe@mail.com',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.black12),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choose a password",
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password too short';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      hintStyle: GoogleFonts.openSans(
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      hintText: 'min. of 8 characters',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.black12),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          onPressed:
                          _isButtonDisabled ? null : () => handleSubmit(),
                          child: _loading
                              ? const SizedBox(
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : Text(
                            'Login',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                        TextSpan(
                          text: 'Register',
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const RegisterScreen();
                                },
                              ));
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
