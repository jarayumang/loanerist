import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loanerist/src/features/report.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants/color.dart';
import '../features/dashboard.dart';

class Monthly_Report_Card extends StatefulWidget {
  const Monthly_Report_Card({Key? key}) : super(key: key);

  @override
  State<Monthly_Report_Card> createState() => _Monthly_Report_CardState();
}

class _Monthly_Report_CardState extends State<Monthly_Report_Card> {
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
                builder: (context) => Reports(),
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
