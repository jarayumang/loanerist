import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({Key? key}) : super(key: key);

  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
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
              'August 2023',
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