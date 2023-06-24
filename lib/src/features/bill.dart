import 'package:flutter/material.dart';
import 'package:loanerist/src/features/add_bill.dart';

import '../constants/color.dart';
import '../constants/page_style.dart';
import '../constants/text_style.dart';

class Bill extends StatefulWidget {
  const Bill({Key? key}) : super(key: key);

  @override
  State<Bill> createState() => _BillState();
}

class _BillState extends State<Bill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.lightBlack,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Bills',
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
                        builder: (context) => AddBill(),
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
                  flex: 1,
                  child: Container(
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
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
                              children: [
                                Text(
                                  'Home',
                                  style: TextStyle(
                                      fontFamily: 'GilroyRegular',
                                      fontSize: 13,
                                      color: ColorConstants.darkWhite,
                                      letterSpacing: 0.5),
                                ),
                                Text(
                                  'P20,000',
                                  style: TextStyle(
                                      fontFamily: 'GilroyBold',
                                      fontSize: 25,
                                      color: ColorConstants.darkWhite,
                                      letterSpacing: 0.7),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Theraphy',
                                style: TextStyle(
                                    fontFamily: 'GilroyRegular',
                                    fontSize: 13,
                                    color: ColorConstants.darkWhite,
                                    letterSpacing: 0.5),
                              ),
                              Text(
                                'P50,000',
                                style: TextStyle(
                                    fontFamily: 'GilroyBold',
                                    fontSize: 25,
                                    color: ColorConstants.darkWhite,
                                    letterSpacing: 0.7),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Expanded(
                flex: 9,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    child: GridView.count(
                      // childAspectRatio: (1 / 0.65),
                      // physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 1.8,
                            widthFactor: 1.2,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .white, // Customize the background color as needed
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      // Adjust the padding as desired
                                      child: Icon(
                                        Icons.sports_rugby_rounded,
                                        size: 30,
                                        // Adjust the size of the icon as desired
                                        color: Colors
                                            .red, // Customize the icon color as needed
                                      ),
                                    ),
                                    Text(
                                      'Digital Ocean',
                                      style: TextStyle(
                                          fontFamily: 'GilroyMedium',
                                          fontSize: 13,
                                      letterSpacing: 0.2),
                                    ),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 1.8,
                            widthFactor: 1.2,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .white, // Customize the background color as needed
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      // Adjust the padding as desired
                                      child: Icon(
                                        Icons.sports_rugby_rounded,
                                        size: 30,
                                        // Adjust the size of the icon as desired
                                        color: Colors
                                            .red, // Customize the icon color as needed
                                      ),
                                    ),
                                    Text(
                                      '8',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FractionallySizedBox(
                            alignment: Alignment.topCenter,
                            heightFactor: 1.8,
                            widthFactor: 1.2,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.red),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors
                                            .white, // Customize the background color as needed
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      // Adjust the padding as desired
                                      child: Icon(
                                        Icons.sports_rugby_rounded,
                                        size: 30,
                                        // Adjust the size of the icon as desired
                                        color: Colors
                                            .red, // Customize the icon color as needed
                                      ),
                                    ),
                                    Text(
                                      '8',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 20),
                                    ),
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          fontFamily: 'GilroyBold',
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
