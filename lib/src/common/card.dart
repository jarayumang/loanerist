import 'package:flutter/material.dart';

class Loan extends StatelessWidget {
  const Loan({Key? key, required this.color1, required this.text1})
      : super(key: key);

  final Color color1;
  final Text text1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      color: color1,
      child: text1,
    );
  }
}
