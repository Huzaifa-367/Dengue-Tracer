import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats_Sector_Monthly extends StatefulWidget {
  const Stats_Sector_Monthly({Key? key}) : super(key: key);

  @override
  State<Stats_Sector_Monthly> createState() => _Stats_Sector_MonthlyState();
}

class _ChartData {
  _ChartData(this.month, this.cases);

  final String month;
  final int cases;
}

class _Stats_Sector_MonthlyState extends State<Stats_Sector_Monthly> {
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
    var response = await Dio()
        .get('$api/GetDengueCasesBySectorMonth?sec_id=${loggedInUser!.sec_id}');
    if (response.statusCode == 200) {
      var data = response.data['cases'];
      maxCaseValue = response.data['maxValue'];
      for (var item in data) {
        // Trimming the time part from the date
        var trimmedDate = item['date'].toString().split('T')[0];

        _chartData.add(_ChartData(trimmedDate, item['count']));
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
                  //opposedPosition: true,
                  autoScrollingMode: AutoScrollingMode.end,
                  visibleMaximum: 5,
                  interval: 1,
                ),
                zoomPanBehavior: ZoomPanBehavior(
                  enablePanning: true,
                ),
                primaryYAxis: NumericAxis(
                  //numberFormat: NumberFormat('##########人'),

                  minimum: 0,
                  maximum: double.parse(maxCaseValue.toString()),
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
