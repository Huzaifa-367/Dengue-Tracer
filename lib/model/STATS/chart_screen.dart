// import 'dart:convert';
// import 'package:dengue_tracing_application/Global/constant.dart';
// import 'package:dengue_tracing_application/Global/text_widget.dart';
// //import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:http/http.dart' as http;

// class chart_screen extends StatefulWidget {
//   const chart_screen({super.key});

//   @override
//   State<chart_screen> createState() => _chart_screenState();
// }

// class DengueUser {
//   String name;
//   String email;
//   String phoneNumber;
//   String role;
//   String homeLocation;
//   //String officeLocation;
//   int secId;
//   String secName;
//   // String latLong;
//   String startDate;
//   bool status;
//   //String endDate;

//   DengueUser({
//     required this.name,
//     required this.email,
//     required this.phoneNumber,
//     required this.role,
//     required this.homeLocation,
//     //required this.officeLocation,
//     required this.secId,
//     required this.secName,
//     // required this.latLong,
//     required this.startDate,
//     required this.status,
//     //required this.endDate
//   });

//   factory DengueUser.fromJson(Map<String, dynamic> json) {
//     return DengueUser(
//       name: json['name'],
//       email: json['email'],
//       phoneNumber: json['phone_number'],
//       role: json['role'],
//       homeLocation: json['home_location'],
//       //officeLocation: json['office_location'],
//       secId: json['sec_id'],
//       secName: json['sec_name'],
//       //latLong: json['lat_long'],
//       startDate: json['startdate'],
//       status: json['status'],
//       //endDate: json['enddate'],
//     );
//   }
// }

// class _ChartData {
//   _ChartData(this.x, this.y);

//   final String x;
//   final double y;
// }

// late List<_ChartData> data;
// late TooltipBehavior _tooltip;

// class _chart_screenState extends State<chart_screen> {
//   Future<List<DengueUser>> fetchDengueUsers() async {
//     final response = await http.get(Uri.parse('$ip/GetDengueUsers'));
//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => DengueUser.fromJson(data)).toList();
//     } else {
//       throw Exception('Failed to load data from API');
//     }
//   }

//   @override
//   void initState() {
//     _tooltip = TooltipBehavior(enable: true);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<DengueUser>>(
//       future: fetchDengueUsers(),
//       builder:
//           (BuildContext context, AsyncSnapshot<List<DengueUser>> snapshot) {
//         if (snapshot.hasData) {
//           List<_ChartData> chartData = [];

//           // Convert the fetched data into chart data
//           for (var user in snapshot.data!) {
//             chartData.add(_ChartData(user.startDate, user.status == 1 ? 1 : 0));
//           }

//           return Column(
//             children: [
//               Row(
//                 children: [
//                   TextWidget(
//                     title: "No. Of Cases",
//                     txtSize: 15,
//                     txtColor: txtColor,
//                   )
//                 ],
//               ),
//               SfCartesianChart(
//                 primaryXAxis: CategoryAxis(),
//                 primaryYAxis: NumericAxis(minimum: 0, maximum: 1, interval: 1),
//                 tooltipBehavior: _tooltip,
//                 series: <ChartSeries<_ChartData, String>>[
//                   ColumnSeries<_ChartData, String>(
//                       dataSource: chartData,
//                       xValueMapper: (_ChartData data, _) => data.x,
//                       yValueMapper: (_ChartData data, _) => data.y,
//                       name: 'Dengue Cases',
//                       color: btnColor,
//                       borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(5.0),
//                           topRight: Radius.circular(5.0))),
//                 ],
//               ),
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class chart_screen extends StatefulWidget {
  const chart_screen({super.key});

  @override
  _chart_screenState createState() => _chart_screenState();
}

class _chart_screenState extends State<chart_screen> {
  final List<_ChartData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _getChartData();
  }

  void _getChartData() async {
    var response = await http.get(Uri.parse('$ip/GetDengueCasesByDate'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        _chartData.add(_ChartData(DateTime.parse(item['Date']), item['Count']));
       
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _chartData.isNotEmpty
        ? SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <LineSeries<_ChartData, DateTime>>[
              LineSeries<_ChartData, DateTime>(
                dataSource: _chartData,
                xValueMapper: (_ChartData data, _) => data.date,
                yValueMapper: (_ChartData data, _) => data.cases,
              )
            ],
          )
        : const CircularProgressIndicator();
  }
}

class _ChartData {
  _ChartData(this.date, this.cases);

  final DateTime date;
  final int cases;
}
