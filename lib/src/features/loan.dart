import 'package:flutter/material.dart';

class Loan extends StatefulWidget {
  const Loan({Key? key}) : super(key: key);

  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Loans',
      style: TextStyle(fontSize: 30),
    );
  }
}
