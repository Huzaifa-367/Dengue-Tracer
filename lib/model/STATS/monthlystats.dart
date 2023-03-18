//import 'package:fl_chart/fl_chart.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyData extends StatefulWidget {
  const MonthlyData({Key? key}) : super(key: key);

  @override
  State<MonthlyData> createState() => _MonthlyDataState();
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class _MonthlyDataState extends State<MonthlyData> {
  //Line Chart Graph Data
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('1', 1112),
      _ChartData('2', 1500),
      _ChartData('3', 3000),
      _ChartData('4', 236),
      _ChartData('5', 1467),
      _ChartData('6', 3678),
      _ChartData('7', 1208),
      _ChartData('8', 1112),
      _ChartData('9', 1500),
      _ChartData('10', 3000),
      _ChartData('11', 236),
      _ChartData('12', 1467),
      _ChartData('13', 3678),
      _ChartData('14', 1208),
      _ChartData('15', 1112),
      _ChartData('16', 1500),
      _ChartData('17', 3000),
      _ChartData('18', 236),
      _ChartData('19', 1467),
      _ChartData('20', 3678),
      _ChartData('21', 1112),
      _ChartData('22', 1500),
      _ChartData('23', 3000),
      _ChartData('24', 236),
      _ChartData('25', 1467),
      _ChartData('26', 3678),
      _ChartData('27', 1208),
      _ChartData('28', 1112),
      _ChartData('29', 1500),
      _ChartData('30', 3000),
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
            visibleMaximum: 10,
            autoScrollingMode: AutoScrollingMode.start,
            //plotOffset: 5,
            //edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 1,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 4000,
            interval: 200,
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
                    topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
          ],
        ),
      ],
    );
  }
}
