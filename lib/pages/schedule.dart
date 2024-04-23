import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loanerist/constants/colors.dart';
import 'package:loanerist/constants/computation.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: Container(
              padding: EdgeInsets.only(left: 15.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: FaIcon(
                  FontAwesomeIcons.squareCaretLeft,
                  color: ColorConstants.blackColor,
                  size: 25,
                ),
              ),
              height: 45,
              width: 45,
            ),
            leadingWidth: 71,
            title: Text('Monthly Dues',
                style: TextStyle(
                    color: ColorConstants.blackColor,
                    fontFamily: 'NoirPro',
                    fontSize: 16,
                    fontWeight: FontWeight.w800)),
            centerTitle: true,
            backgroundColor: ColorConstants.whiteColor,
            ),
        body: Container(
            padding: EdgeInsets.all(15.0),
            width: double.infinity,
            color: ColorConstants.whiteColor,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.caretLeft,
                        color: ColorConstants.blackColor,
                        size: 25,
                      ),
                      todayMonth(),
                      GestureDetector(
                        onTap: () async {
                          List<Map<String, dynamic>> loans = await getAllLoans();
                          print(loans);
                          for (var dateRange in loans) {
                            List<String> monthsInRange = getMonthsInRange(dateRange);
                            print('Months within range for ${dateRange['start']} to ${dateRange['end']}: $monthsInRange');
                          }
                        },
                        child: FaIcon(
                          FontAwesomeIcons.caretRight,
                          color: ColorConstants.blackColor,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        )
    );
  }
}

Container todayMonth() {
  var dateNow = DateTime.now();
  var currentMonth = dateNow.month;

  return Container(
    child: Text(months[currentMonth - 1],
        style: TextStyle(
            color: ColorConstants.blackColor,
            fontFamily: 'NoirPro',
            fontSize: 20,
            fontWeight: FontWeight.w800)),
  );
}

//TODO:Backend Shits
// 1. Get today's month DONE
// 2. Check the budget and loans
// 2.1. Every budget and loan should return an array with the date included inside
// 2.2. If today's month is included in teh array, teh loan/budget will show in the list
// 2.3. Create an array that includes it all