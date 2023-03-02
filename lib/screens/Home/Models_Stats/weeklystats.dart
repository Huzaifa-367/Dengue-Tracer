import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyData extends StatefulWidget {
  const WeeklyData({Key? key}) : super(key: key);

  @override
  State<WeeklyData> createState() => _WeeklyDataState();
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _WeeklyDataState extends State<WeeklyData> {
  //Line Chart Graph Data
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('MON', 1112),
      _ChartData('TUE', 1500),
      _ChartData('WED', 3000),
      _ChartData('THR', 236),
      _ChartData('FRI', 1467),
      _ChartData('SAT', 3678),
      _ChartData('SUN', 1208),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

//Line Chart Graph End
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
        SfCartesianChart(
          //borderColor: btnColor,
          //borderWidth: 1,
          //backgroundColor: bkColor,
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(minimum: 0, maximum: 4000, interval: 200),
          tooltipBehavior: _tooltip,
          series: <ChartSeries<_ChartData, String>>[
            ColumnSeries<_ChartData, String>(
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Dengue Cases',
                color: btnColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0))),
          ],
        ),
      ],
    );
  }
}
