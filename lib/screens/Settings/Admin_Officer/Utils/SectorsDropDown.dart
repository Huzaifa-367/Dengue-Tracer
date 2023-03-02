import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

class SectorsDrop extends StatefulWidget {
  const SectorsDrop({
    Key? key,
  }) : super(key: key);

  @override
  State<SectorsDrop> createState() => _SectorsDropState();
}

class _SectorsDropState extends State<SectorsDrop> {
  List<String> dataString = [
    "Satellite Town",
    "ShamsAbad",
    "Pindora",
    "RehmanAbad",
    "FaizAbad",
    "SadiqAbad",
    "Raja Bazar",
    'Sadar'
  ];
  String? selectedString;
  List<String>? selectedDataString;

  @override
  Widget build(BuildContext context) {
    return CustomMultiSelectField<String>(
      //decoration: const InputDecoration(),
      title: "Sectors",
      items: dataString,
      enableAllOptionSelect: true,
      onSelectionDone: _onCountriesSelectionComplete,
      itemAsString: (item) => item.toString(),
    );
  }

  void _onCountriesSelectionComplete(value) {
    selectedDataString?.addAll(value);
    setState(() {});
  }
}
