import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

class RangeSlidr extends StatefulWidget {
  const RangeSlidr({Key? key}) : super(key: key);

  @override
  State<RangeSlidr> createState() => _RangeSlidrState();
}

class _RangeSlidrState extends State<RangeSlidr> {
  double _currentSliderValue = 1.0;
  @override
  Widget build(BuildContext context) {
    return //Dialog
        Slider(
      activeColor: btnColor,
      value: _currentSliderValue,
      min: 1,
      max: 500,
      divisions: 10,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(
          () {
            _currentSliderValue = value;
          },
        );
      },
    );
  }
}
