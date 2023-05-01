import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
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
