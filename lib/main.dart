import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loanerist/authentication/login.dart';
import 'package:loanerist/start/welcome_part_one.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDnSYamn3oa-kMICRacJmSO4NdS3begDhc",
              appId: "1:6572051136:android:54b05d83b09f4dea383b25",
              messagingSenderId: "6572051136",
              projectId: "loanerist"))
      : await Firebase.initializeApp();
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  late Stream<User?> _userStream;

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final user = snapshot.data;
        if (user != null) {
          return const MaterialApp(
            home: WelcomeOne(),
          );
        } else {
          return const MaterialApp(
            home: LogIn(),
          );
        }
      },
    );
  }
}
