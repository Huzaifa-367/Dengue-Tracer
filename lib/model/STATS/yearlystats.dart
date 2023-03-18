//import 'package:fl_chart/fl_chart.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearlyData extends StatefulWidget {
  const YearlyData({Key? key}) : super(key: key);
  @override
  State<YearlyData> createState() => _YearlyDataState();
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _YearlyDataState extends State<YearlyData> {
  //Line Chart Graph Data
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('JAN', 54670),
      _ChartData('FEB', 53460),
      _ChartData('MAR', 88720),
      _ChartData('APR', 75761),
      _ChartData('MAY', 15467),
      _ChartData('JUN', 38678),
      _ChartData('JULY', 11768),
      _ChartData('AUG', 33000),
      _ChartData('SEP', 22766),
      _ChartData('OCT', 15679),
      _ChartData('NOV', 36789),
      _ChartData('DEC', 1258),
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
          // borderColor: btnColor,
          // borderWidth: 2,
          //backgroundColor: bkColor,
          primaryXAxis: CategoryAxis(
            visibleMaximum: 7,
            autoScrollingMode: AutoScrollingMode.start,
            interval: 1,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 100000,
            interval: 5000,
          ),
          tooltipBehavior: _tooltip,
          //To Enable Scrolling
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
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
