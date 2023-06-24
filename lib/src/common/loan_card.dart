import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/src/features/report.dart';
import 'package:loanerist/src/features/view_loan.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants/color.dart';
import '../features/dashboard.dart';

class Loan_Card extends StatefulWidget {
  const Loan_Card({Key? key}) : super(key: key);

  @override
  State<Loan_Card> createState() => _Loan_CardState();
}

class _Loan_CardState extends State<Loan_Card> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: InkWell(
          onTap: () {
            // Navigate to another page here
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewLoan(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.lightBlackBorder, // Specify the background color
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: ColorConstants.lightBlackCard, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: 0.6,
                      center: Text(
                        '${(0.6 * 100).toStringAsFixed(0)}%',
                        style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15, color: Colors.white),
                      ),
                      progressColor: ColorConstants.lightBlue,
                      backgroundColor: ColorConstants.lightBlackCard,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly Computation for May',
                          style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(height: 5,
                        ),
                        Text(
                          'P39,500 of P40,000',
                          style: TextStyle(fontFamily: 'GilroyBold', fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )

      ),
    );
  }
}
