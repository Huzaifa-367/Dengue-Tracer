import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

class RangeSlidr extends StatefulWidget {
  const RangeSlidr({Key? key}) : super(key: key);

  @override
  State<RangeSlidr> createState() => _RangeSlidrState();
}

class _RangeSlidrState extends State<RangeSlidr> {
  @override
  Widget build(BuildContext context) {
    return //Dialog
        Slider(
      activeColor: btnColor,
      value: currentSliderValue,
      min: 1,
      max: 500,
      divisions: 10,
      label: currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(
          () {
            currentSliderValue = value;
          },
        );
      },
    );
  }
}
