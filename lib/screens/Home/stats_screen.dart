import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:dengue_tracing_application/screens/Home/notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:dengue_tracing_application/Global/Paths.dart';
import 'package:dengue_tracing_application/model/STATS/monthlystats.dart';
import 'package:dengue_tracing_application/model/STATS/yearlystats.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:badges/badges.dart' as badges;

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _ChartData {
  _ChartData(this.date, this.cases);

  final String date;
  final int cases;
}

class _StatsScreenState extends State<StatsScreen> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  final List<_ChartData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    _getChartData();
  }

  void _getChartData() async {
    var response = await http.get(Uri.parse('$ip/GetDengueCasesByDate'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        // Trimming the time part from the date
        var trimmedDate = item['Date'].toString().split('T')[0];

        _chartData.add(_ChartData(trimmedDate, item['Count']));
      }
      setState(() {});
    }
  }

  void getChartDatabyrange(
    DateTime? From,
    DateTime? To,
  ) async {
    if (FromDate == null || ToDate == null) {
      return;
    }

    var from = FromDate!.toIso8601String().split('T')[0];
    var to = ToDate!.toIso8601String().split('T')[0];
    var response = await http
        .get(Uri.parse('$ip/GetDengueCasesByDateRange?from=$from&to=$to'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _chartData.clear();
      for (var item in data) {
        // Trimming the time part from the date
        var trimmedDate = item['Date'].toString().split('T')[0];

        _chartData.add(_ChartData(trimmedDate, item['Count']));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double bannerHeight = 200;
    return DefaultTabController(
      length: 3,
      child: Container(
        color: ScfColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ScfColor,
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 15,
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                          title: "Cases Report",
                          txtSize: 25,
                          txtColor: txtColor,
                        ),
                        const SizedBox(
                          width: 130,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: bkColor.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: badges.Badge(
                              badgeContent: Text(
                                '6',
                                style: TextStyle(
                                  color: ScfColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              showBadge: true,
                              ignorePointer: false,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const NotifScreen(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.notifications,
                                  color: btnColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                  //Date Picker Values
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonWidget(
                            btnText: "Pick Date",
                            onPress: () {
                              showCustomDateRangePicker(
                                context,
                                backgroundColor: Colors.white,
                                primaryColor: btnColor,
                                dismissible: true,
                                minimumDate: DateTime.now()
                                    .subtract(const Duration(days: 60)),
                                maximumDate: DateTime.now(),
                                endDate: ToDate,
                                startDate: FromDate,
                                onApplyClick: (start, end) {
                                  setState(() {
                                    ToDate = end;
                                    FromDate = start;
                                    getChartDatabyrange(FromDate, ToDate);
                                  });
                                },
                                onCancelClick: () {
                                  setState(() {
                                    ToDate = null;
                                    FromDate = null;
                                  });
                                },
                              );
                            },
                          ),
                          ButtonWidget(
                            btnText: "Reset",
                            onPress: () {
                              ToDate = null;
                              FromDate = null;
                              setState(() {
                                _getChartData();
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '${FromDate != null ? DateFormat('dd-MMM-yyyy').format(FromDate!) : DateFormat('dd-MMM-yyyy').format(DateTime.now().subtract(const Duration(days: 5)))}  To  ${ToDate != null ? DateFormat('dd-MMM-yyyy').format(ToDate!) : DateFormat('dd-MMM-yyyy').format(DateTime.now())}',
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
                          text: "Daily",
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
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 7.0,
                      right: 5,
                    ),
                    child: SizedBox(
                      height: 850,
                      width: 500,
                      child: TabBarView(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    title: "No. Of Cases",
                                    txtSize: 15,
                                    txtColor: txtColor,
                                  )
                                ],
                              ),
                              _chartData.isEmpty
                                  ? ShimmerListView(10)
                                  : SfCartesianChart(
                                      //enableAxisAnimation: true,
                                      primaryXAxis: CategoryAxis(
                                        //opposedPosition: true,
                                        autoScrollingMode:
                                            AutoScrollingMode.end,
                                        visibleMaximum: 5,
                                        interval: 1,
                                      ),
                                      zoomPanBehavior: ZoomPanBehavior(
                                        enablePanning: true,
                                      ),
                                      primaryYAxis: NumericAxis(
                                        //numberFormat: NumberFormat('##########人'),

                                        minimum: 0,
                                        maximum: 20,
                                        interval: 1,
                                      ),
                                      tooltipBehavior: _tooltip,
                                      series: <ChartSeries<_ChartData, String>>[
                                        ColumnSeries<_ChartData, String>(
                                          dataSource: _chartData,

                                          // emptyPointSettings: EmptyPointSettings(
                                          //     // Mode of empty point
                                          //     mode: EmptyPointMode.average),
                                          xValueMapper: (_ChartData data, _) =>
                                              data.date.toString(),
                                          yValueMapper: (_ChartData data, _) =>
                                              data.cases,
                                          name: 'Dengue Cases',
                                          color: btnColor,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            topRight: Radius.circular(5.0),
                                          ),
                                          //enableTooltip: true,
                                        ),
                                      ],
                                    ),
                            ],
                          ),

                          //chart_screen(),
                          //DailyData(),
                          const MonthlyData(),
                          const YearlyData(),
                        ],
                      ),
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
