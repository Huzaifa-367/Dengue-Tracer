import 'dart:convert';

import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:http/http.dart' as http;

import 'officer_add_Screen.dart';

class OfficersListScreen extends StatefulWidget {
  const OfficersListScreen({Key? key}) : super(key: key);

  @override
  State<OfficersListScreen> createState() => _OfficersListScreenState();
}

class _OfficersListScreenState extends State<OfficersListScreen> {
  TextEditingController text = TextEditingController();
  final _rows = <PlutoRow>[];
  final _columns = [
    PlutoColumn(
      title: 'User ID',
      field: 'user_id',
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Email',
      field: 'email',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Phone Number',
      field: 'phone_number',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Image',
      field: 'image',
      type: PlutoColumnType.text(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await http.get(Uri.parse('$ip/Getofficers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      final List<PlutoRow> rows = data.map<PlutoRow>((item) {
        return PlutoRow(
          cells: {
            'user_id': PlutoCell(value: item['user_id']),
            'name': PlutoCell(value: item['name']),
            'email': PlutoCell(value: item['email']),
            'phone_number': PlutoCell(value: item['phone_number']),
            'role': PlutoCell(value: item['role']),
            'image': PlutoCell(value: item['image']),
          },
        );
      }).toList();

      setState(() {
        _rows.clear();
        _rows.addAll(rows);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //var DataRepository;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OfficerAddScreen(),
                  ));
                }),
                icon: Icon(
                  Icons.add_box_rounded,
                  size: 30,
                  color: btnColor,
                ),
              ),
            ],
            title: TextWidget(
                title: "All Health Officers", txtSize: 20, txtColor: txtColor),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                // const OfficersScreen(),
                Container(
                  color: btnColor,
                  height: 690,
                  child: PlutoGrid(
                    columns: _columns,
                    rows: _rows,
                    onChanged: (PlutoGridOnChangedEvent event) {},
                    onLoaded: (PlutoGridOnLoadedEvent event) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
