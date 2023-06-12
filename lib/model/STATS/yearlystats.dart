import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class YearlyData extends StatefulWidget {
  const YearlyData({Key? key}) : super(key: key);

  @override
  State<YearlyData> createState() => _YearlyDataState();
}

class _ChartData {
  _ChartData(this.year, this.cases);

  final String year;
  final int cases;
}

class _YearlyDataState extends State<YearlyData> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  final List<_ChartData> _chartData = [];

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(enable: true);
    _getChartData();
  }

  int maxCaseValue = 0;
  void _getChartData() async {
    try {
      var response = await Dio().get('$api/GetDengueCasesByYear');
      if (response.statusCode == 200) {
        var data = response.data['cases'];
        maxCaseValue = response.data['maxValue'];
        for (var item in data) {
          // Trimming the time part from the date
          var all = item['date'].toString().split('T')[0];
          var year = all.split('-')[0];
          //var month = all.split('-')[1];
          var trimmedDate = year;

          _chartData.add(_ChartData(trimmedDate, item['count']));
        }

        setState(() {});
      }
    } catch (e) {
      //
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
                  maximum: double.parse(maxCaseValue.toString()),
                  interval: 1,
                ),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<_ChartData, String>>[
                  ColumnSeries<_ChartData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_ChartData data, _) => data.year.toString(),
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
