import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Stats_MultiAxex extends StatefulWidget {
  const Stats_MultiAxex({super.key});

  @override
  State<Stats_MultiAxex> createState() => _Stats_MultiAxexState();
}

class _Stats_MultiAxexState extends State<Stats_MultiAxex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple Axes Example'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Primary Y-Axis'),
            ),
            axes: <ChartAxis>[
              NumericAxis(
                opposedPosition: true,
                title: AxisTitle(text: 'Secondary Y-Axis'),
              ),
            ],
            series: <ChartSeries>[
              LineSeries<Data, String>(
                dataSource: [
                  Data('Jan', 10, 20),
                  Data('Feb', 15, 25),
                  Data('Mar', 12, 18),
                  Data('Apr', 8, 16),
                  Data('May', 11, 21),
                ],
                xValueMapper: (Data data, _) => data.month,
                yValueMapper: (Data data, _) => data.primaryValue,
                yAxisName: 'Primary Y-Axis',
              ),
              LineSeries<Data, String>(
                dataSource: [
                  Data('Jan', 50, 10),
                  Data('Feb', 55, 90),
                  Data('Mar', 60, 70),
                  Data('Apr', 65, 85),
                  Data('May', 70, 50),
                ],
                xValueMapper: (Data data, _) => data.month,
                yValueMapper: (Data data, _) => data.secondaryValue,
                yAxisName: 'Secondary Y-Axis',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Data {
  final String month;
  final double primaryValue;
  final double secondaryValue;

  Data(this.month, this.primaryValue, this.secondaryValue);
}
