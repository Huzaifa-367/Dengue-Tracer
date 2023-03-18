// import 'package:flutter/material.dart';
// import 'package:flutter_custom_selector/flutter_custom_selector.dart';

// class SectorsDrop extends StatefulWidget {
//   const SectorsDrop({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SectorsDrop> createState() => _SectorsDropState();
// }

// class _SectorsDropState extends State<SectorsDrop> {
//   List<String> dataString = [
//     "Satellite Town",
//     "ShamsAbad",
//     "Pindora",
//     "RehmanAbad",
//     "FaizAbad",
//     "SadiqAbad",
//     "Raja Bazar",
//     'Sadar'
//   ];
//   String? selectedString;
//   List<String>? selectedDataString;

//   @override
//   Widget build(BuildContext context) {
//     return CustomMultiSelectField<String>(
//       //decoration: const InputDecoration(),
//       title: "Sectors",
//       items: dataString,
//       enableAllOptionSelect: true,
//       onSelectionDone: _onCountriesSelectionComplete,
//       itemAsString: (item) => item.toString(),
//     );
//   }

//   void _onCountriesSelectionComplete(value) {
//     selectedDataString?.addAll(value);
//     setState(() {});
//   }
// }

// '$ip/GetSectors'

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SectorsDrop extends StatefulWidget {
  const SectorsDrop({Key? key}) : super(key: key);

  @override
  _SectorsDropState createState() => _SectorsDropState();
}

class _SectorsDropState extends State<SectorsDrop> {
  List<String>? sectors;
  List<String>? selectedDataString;

  Future<List<String>> fetchSectors() async {
    final response = await http.get(Uri.parse('$ip/GetSectors'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final sectors = jsonData
          .map((e) => e['sec_name'] != null ? e['sec_name'].toString() : '')
          .toList();
      return sectors;
    } else {
      throw Exception("Failed to fetch sectors data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: fetchSectors(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          sectors = snapshot.data;
          return CustomMultiSelectField<String>(
            title: "Sectors",
            items: sectors!,
            enableAllOptionSelect: true,
            onSelectionDone: _onSelectionComplete,
            itemAsString: (item) => item.toString(),
          );
        } else if (snapshot.hasError) {
          return const Text("Error fetching sectors data");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  void _onSelectionComplete(value) {
    selectedDataString?.addAll(value);
    setState(() {});
    // handle selection completion
  }
}
