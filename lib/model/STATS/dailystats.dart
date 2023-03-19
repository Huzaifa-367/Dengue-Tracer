// import 'package:dengue_tracing_application/Global/constant.dart';
// import 'package:dengue_tracing_application/Global/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class DailyData extends StatefulWidget {
//   const DailyData({Key? key}) : super(key: key);

//   @override
//   State<DailyData> createState() => _DailyDataState();
// }

// class _ChartData {
//   _ChartData(this.date, this.cases);

//   final String date;
//   final int cases;
// }

// class _DailyDataState extends State<DailyData> {
//   late List<_ChartData> data;
//   late TooltipBehavior _tooltip;
//   final List<_ChartData> _chartData = [];



//   @override
//   void initState() {
//     super.initState();
//     _tooltip = TooltipBehavior(enable: true);
//     _getChartData();
//   }

//   void _getChartData() async {
//     var response = await http.get(Uri.parse('$ip/GetDengueCasesByDate'));
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       for (var item in data) {
//         // Trimming the time part from the date
//         var trimmedDate = item['Date'].toString().split('T')[0];

//         _chartData.add(_ChartData(trimmedDate, item['Count']));
//       }
//       setState(() {});
//     }
//   }

//   void _getChartDatabyrange() async {
//     if (FromDate == null || ToDate == null) {
//       return;
//     }

//     var from = FromDate!.toIso8601String();
//     var to = ToDate!.toIso8601String();
//     var response = await http
//         .get(Uri.parse('$ip/GetDengueCasesByDateRange?from=$from&to=$to'));

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       _chartData.clear();
//       for (var item in data) {
//         // Trimming the time part from the date
//         var trimmedDate = item['Date'].toString().split('T')[0];

//         _chartData.add(_ChartData(trimmedDate, item['Count']));
//       }
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             TextWidget(
//               title: "No. Of Cases",
//               txtSize: 15,
//               txtColor: txtColor,
//             )
//           ],
//         ),
//         SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           primaryYAxis: NumericAxis(minimum: 0, maximum: 20, interval: 1),
//           tooltipBehavior: _tooltip,
//           series: <ChartSeries<_ChartData, String>>[
//             ColumnSeries<_ChartData, String>(
//                 dataSource: _chartData,
//                 xValueMapper: (_ChartData data, _) => data.date.toString(),
//                 yValueMapper: (_ChartData data, _) => data.cases,
//                 name: 'Dengue Cases',
//                 color: btnColor,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(5.0),
//                     topRight: Radius.circular(5.0))),
//           ],
//         ),
//       ],
//     );
//   }
// }
