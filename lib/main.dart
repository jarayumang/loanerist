import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/card.dart';
import 'package:loanerist/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MyStatefulWidget();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        const Loan(
          color1: Colors.red,
          text1: Text('blue'),
        ),
        const Loan(
          color1: Colors.blue,
          text1: Text('red'),
        ),
        Container(
          height: 100.0,
          color: Colors.green,
        ),
        Container(
          height: 100.0,
          color: Colors.yellow,
        ),
        Container(
          height: 100.0,
          color: Colors.orange,
        ),
        Container(
          height: 100.0,
          color: Colors.red,
        ),
        Container(
          height: 100.0,
          color: Colors.blue,
        ),
        Container(
          height: 100.0,
          color: Colors.green,
        ),
        Container(
          height: 100.0,
          color: Colors.yellow,
        ),
        Container(
          height: 100.0,
          color: Colors.orange,
        ),
      ],
    ),
    const Text(
      'Index 1: Business',
    ),
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign Out')),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('My Finances', style: TextStyle(color: Colors.amber[800])),
        actions: <Widget>[
          IconButton(
            color: Colors.amber[800],
            icon: const Icon(
              Icons.add,
            ),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 20),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.credit_score,
                      size: _selectedIndex == 0 ? 28 : 23),
                  label: 'Loans',
                ),
                BottomNavigationBarItem(
                  icon:
                      Icon(Icons.payments, size: _selectedIndex == 1 ? 28 : 23),
                  label: 'Bills',
                ),
                BottomNavigationBarItem(
                  icon:
                      Icon(Icons.settings, size: _selectedIndex == 2 ? 28 : 23),
                  label: 'Settings',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white70,
              onTap: _onItemTapped,
              backgroundColor: Colors.amber[800],
            ),
          ),
        ),
      ),
    );
  }
}
