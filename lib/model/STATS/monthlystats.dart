import 'package:dengue_tracing_application/Global/Widgets/Shimmer_List_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/Widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MonthlyData extends StatefulWidget {
  const MonthlyData({Key? key}) : super(key: key);

  @override
  State<MonthlyData> createState() => _MonthlyDataState();
}

class _ChartData {
  _ChartData(this.month, this.cases);

  final String month;
  final int cases;
}

class _MonthlyDataState extends State<MonthlyData> {
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
    var response = await http.get(Uri.parse('$ip/GetDengueCasesByMonth'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        // Trimming the time part from the date
        var trimmedDate = item['Month'].toString().split('T')[0];

        _chartData.add(_ChartData(trimmedDate, item['Count']));
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                primaryXAxis: CategoryAxis(
                  interval: 1,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 20,
                  interval: 1,
                ),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_ChartData data, _) => data.month.toString(),
                    yValueMapper: (_ChartData data, _) => data.cases,
                    name: 'Dengue Cases',
                    color: btnColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
