import 'package:flutter/material.dart';
import 'package:loanerist/src/features/add_bill.dart';
import 'package:loanerist/src/features/add_loan.dart';

import '../common/loan_card.dart';
import '../constants/color.dart';
import '../constants/page_style.dart';
import '../constants/text_style.dart';

class Loan extends StatefulWidget {
  const Loan({Key? key}) : super(key: key);

  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlack,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Loans',
          style: homeScreenHeaderTextStyle,
        ),
        titleSpacing: 0.0,
        actions: [
          Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddLoan(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add_rounded,
                  color: ColorConstants.darkWhite,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
      ),
      body: Container(
        padding: pagePadding,
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: ColorConstants.lightBlackBorder,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Amount',
                                style: TextStyle(
                                    fontFamily: 'GilroySemiBold',
                                    fontSize: 15,
                                    color: ColorConstants.darkWhite,
                                    letterSpacing: 0.5),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'P',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 15,
                                          color: ColorConstants.darkWhite,
                                          letterSpacing: 0.7),
                                    ),
                                    Text(
                                      '20,000',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 30,
                                          color: ColorConstants.darkWhite,
                                          letterSpacing: 0.7),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Count',
                                style: TextStyle(
                                    fontFamily: 'GilroySemiBold',
                                    fontSize: 15,
                                    color: ColorConstants.darkWhite,
                                    letterSpacing: 0.5),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                      fontFamily: 'GilroyBold',
                                      fontSize: 30,
                                      color: ColorConstants.darkWhite,
                                      letterSpacing: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text(
                      'Loans List',
                      style: TextStyle(
                          fontFamily: 'GilroyBold',
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                          Loan_Card(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
