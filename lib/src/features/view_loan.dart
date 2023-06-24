import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';

class ViewLoan extends StatefulWidget {
  const ViewLoan({Key? key}) : super(key: key);

  @override
  State<ViewLoan> createState() => _ViewLoanState();
}

class _ViewLoanState extends State<ViewLoan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
      backgroundColor: ColorConstants.lightBlack,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: ColorConstants.darkWhite,
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Center(
            child: Text(
              'View Loan',
              style: const TextStyle(fontFamily: 'GilroyBold', fontSize: 20),
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(
                    Icons.calendar_month_rounded,
                    color: ColorConstants.darkWhite,
                  )),
            )
          ],
        ),
    );
  }
}