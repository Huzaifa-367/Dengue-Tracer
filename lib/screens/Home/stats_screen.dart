import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dengue_tracing_application/screens/Home/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/model/STATS/monthlystats.dart';
import 'package:dengue_tracing_application/model/STATS/weeklystats.dart';
import 'package:dengue_tracing_application/model/STATS/yearlystats.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextWidget(
                        title: "Cases Report",
                        txtSize: 25,
                        txtColor: txtColor,
                      ),
                      const SizedBox(
                        width: 140,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotifScreen(),
                          ));
                        },
                        icon: const Icon(
                          Icons.notifications,
                          size: 35,
                        ),
                        // icon: const Icon(
                        //   size: 35,
                        //   Icons.notifications,
                        // ),
                        color: btnColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Divider(
                      thickness: 2,
                      color: btnColor,
                    ),
                  ),
                  Column(
                    children: [
                      ButtonWidget(
                        btnText: "Pick Date",
                        onPress: () {
                          showCustomDateRangePicker(
                            context,
                            backgroundColor: Colors.transparent,
                            primaryColor: Colors.transparent,
                            dismissible: true,
                            minimumDate: DateTime.now()
                                .subtract(const Duration(days: 60)),
                            maximumDate: DateTime.now(),
                            endDate: endDate,
                            startDate: startDate,
                            onApplyClick: (start, end) {
                              setState(() {
                                endDate = end;
                                startDate = start;
                              });
                            },
                            onCancelClick: () {
                              setState(() {
                                endDate = null;
                                startDate = null;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${startDate != null ? DateFormat("dd, MMM,yyyy").format(startDate!) : '-'}  To  ${endDate != null ? DateFormat("dd, MMM,yyyy").format(endDate!) : '-'}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      //top: 20.0,
                      right: 5,
                      left: 5,
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      splashBorderRadius: BorderRadius.circular(25),
                      //indicatorWeight: 9,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      //indicatorColor: Colors.amber,
                      indicator: BoxDecoration(

                          //shape: BoxShape.rectangle,
                          border: const Border.symmetric(),
                          borderRadius:
                              BorderRadius.circular(25), // Creates border
                          color: btnColor), //Change background color from here
                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        const Tab(
                          text: "Weekly",
                        ),
                        const Tab(
                          text: "Monthly",
                        ),
                        const Tab(
                          text: "Yearly",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 7.0,
                      right: 5,
                    ),
                    child: SizedBox(
                      height: 600,
                      width: 500,
                      child: TabBarView(children: [
                        WeeklyData(),
                        MonthlyData(),
                        YearlyData(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
