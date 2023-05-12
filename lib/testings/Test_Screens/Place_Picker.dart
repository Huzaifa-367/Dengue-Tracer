//Link : https://flutterawesome.com/the-missing-location-picker-made-in-flutter-for-flutter-2/

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';

class PickerDemo extends StatefulWidget {
  const PickerDemo({super.key});

  @override
  State<StatefulWidget> createState() => PickerDemoState();
}

class PickerDemoState extends State<PickerDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picker Example')),
      body: Center(
        child: ElevatedButton(
          child: const Text("Pick Delivery location"),
          onPressed: () {
            showPlacePicker();
          },
        ),
      ),
    );
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PlacePicker(mapapikey)));

    // Handle the result in your way
    // print(result);
  }
}
