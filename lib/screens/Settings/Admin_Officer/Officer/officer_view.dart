import 'dart:convert';

import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
      title: 'Sector',
      field: 'sec_name',
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

    // PlutoColumn(
    //   title: 'Role',
    //   field: 'role',
    //   type: PlutoColumnType.text(),
    // ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchwithsectors();
    // _loadData();
  }

  void _fetchwithsectors() async {
    //final response = await http.get(Uri.parse('$ip/Getofficers'));
    final response = await http.get(Uri.parse('$ip/GetOfficerSectors'));

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
            'sec_name': PlutoCell(value: item['sec_name']),
          },
        );
      }).toList();

      setState(() {
        _rows.clear();
        _rows.addAll(rows);
      });
    }
  }

  void _fetchwithoutSectors() async {
    //final response = await http.get(Uri.parse('$ip/Getofficers'));
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
            'sec_name': PlutoCell(value: item['sec_name']),
          },
        );
      }).toList();

      setState(() {
        _rows.clear();
        _rows.addAll(rows);
      });
    }
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAllOfficers = prefs.getBool('IS_ALL') ?? false;
    });
  }

  // ignore: non_constant_identifier_names
  void _getofficers(bool value, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IS_ALL', value);
    if (value == true) {
      _fetchwithsectors();
    } else {
      _fetchwithoutSectors();
    }
  }

  bool _isAllOfficers = false;
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextWidget(
                          title: "All Officers",
                          txtSize: 15,
                          txtColor: txtColor),
                      Switch.adaptive(
                        inactiveTrackColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        inactiveThumbColor:
                            const Color.fromARGB(255, 246, 195, 195),
                        //enableFeedback: true,
                        activeColor: btnColor,
                        value: _isAllOfficers,
                        onChanged: (value) {
                          setState(
                            () {
                              _isAllOfficers = value;
                              _getofficers(value, context);
                            },
                          );
                        },
                      ),
                      TextWidget(
                          title: "Officers with Sectorss",
                          txtSize: 15,
                          txtColor: txtColor),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const OfficersScreen(),
                  Container(
                    color: ScfColor,
                    height: 600,
                    child: PlutoGrid(
                      configuration: PlutoGridConfiguration(
                        style: PlutoGridStyleConfig(
                          borderColor: btnColor,
                          gridBorderColor: btnColor,
                          gridBorderRadius: BorderRadius.circular(12),
                          //rowColor: btnColor,
                          columnTextStyle:
                              const TextStyle(fontWeight: FontWeight.w900),
                          cellTextStyle:
                              const TextStyle(fontWeight: FontWeight.w900),
                          activatedBorderColor: btnColor,
                          enableGridBorderShadow: true,
                        ),
                      ),
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
      ),
    );
  }
}
