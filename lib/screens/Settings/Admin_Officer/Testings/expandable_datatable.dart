// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:dengue_tracing_application/testings/Model/Expandable_Model.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/SectorsDropDown.dart';

class Expandable_Table_Screen extends StatefulWidget {
  const Expandable_Table_Screen({Key? key}) : super(key: key);

  @override
  State<Expandable_Table_Screen> createState() =>
      _Expandable_Table_ScreenState();
}

TextEditingController emailcontr = TextEditingController();

class _Expandable_Table_ScreenState extends State<Expandable_Table_Screen> {
  List<Users> userList = [];

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

  bool _isLoading = true;

  void setLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetch();
  }

  void fetch() async {
    userList = await getUsers();

    createDataSource();

    setLoading();
  }

  Future<List<Users>> getUsers() async {
    final String response =
        await rootBundle.loadString('assets/json/dumb.json');

    final data = await json.decode(response);

    API apiData = API.fromJson(data);

    if (apiData.users != null) {
      return apiData.users!;
    }

    return [];
  }

  void createDataSource() {
    headers = [
      ExpandableColumn<int>(columnTitle: "ID", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "First name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Last name", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Maiden name", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Age", columnFlex: 1),
      ExpandableColumn<String>(columnTitle: "Gender", columnFlex: 2),
      ExpandableColumn<String>(columnTitle: "Email", columnFlex: 4),
    ];

    rows = userList.map<ExpandableRow>((e) {
      return ExpandableRow(
        cells: [
          ExpandableCell<int>(columnTitle: "ID", value: e.id),
          ExpandableCell<String>(columnTitle: "First name", value: e.firstName),
          ExpandableCell<String>(columnTitle: "Last name", value: e.lastName),
          ExpandableCell<String>(
              columnTitle: "Middle name", value: e.maidenName),
          ExpandableCell<int>(columnTitle: "Age", value: e.age),
          ExpandableCell<String>(columnTitle: "Gender", value: e.gender),
          ExpandableCell<String>(columnTitle: "Email", value: e.email),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: !_isLoading
            ? LayoutBuilder(builder: (context, constraints) {
                int visibleCount = 3;
                if (constraints.maxWidth < 600) {
                  visibleCount = 3;
                } else if (constraints.maxWidth < 800) {
                  visibleCount = 4;
                } else if (constraints.maxWidth < 1000) {
                  visibleCount = 5;
                } else {
                  visibleCount = 6;
                }

                return ExpandableTheme(
                  data: ExpandableThemeData(
                    paginationBorderRadius: BorderRadius.circular(10),
                    editIcon: Icon(
                      Icons.edit,
                      size: 20,
                      color: btnColor,
                    ),
                    context,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    expandedBorderColor: Colors.transparent,
                    paginationSize: 40,
                    headerHeight: 56,
                    headerColor: btnColor,
                    headerBorder: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    //evenRowColor: const Color(0xFFFFFFFF),
                    //oddRowColor: Colors.amber[200],
                    rowBorder: const BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                    //rowColor: Colors.green,
                    headerTextMaxLines: 4,
                    headerSortIconColor: tbtnColor,
                    paginationBorderColor: btnColor,
                    paginationSelectedFillColor: tbtnColor,
                    paginationSelectedTextColor: Colors.white,
                  ),
                  child: ExpandableDataTable(
                    headers: headers,
                    rows: rows,
                    pageSize: 20,
                    multipleExpansion: false,
                    onRowChanged: (newRow) {
                      print(newRow.cells[01].value);
                    },
                    onPageChanged: (page) {
                      print(page);
                    },
                    renderEditDialog: (row, onSuccess) =>
                        _buildEditDialog(row, onSuccess),
                    visibleColumnCount: visibleCount,
                  ),
                );
              })
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildEditDialog(
      ExpandableRow row, Function(ExpandableRow) onSuccess) {
    return AlertDialog(
      // title: SizedBox(
      //   height: 300,
      //   child: TextButton(
      //     child: const Text("Change name"),
      //     onPressed: () {
      //       row.cells[1].value = "x3";
      //       onSuccess(row);
      //     },
      //   ),
      // ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Name",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.person),
            //sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Email",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.email),
            //sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: MyTextField(
            controller: emailcontr,
            hintText: "Phone Number",
            keytype: TextInputType.text,
            obscureText: false,
            prefixIcon: const Icon(Icons.call),
            // sufixIcon: Icons.remove_red_eye,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SectorsDrop(),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(14),
                child: const TextWidget(
                    title: " Cancel ", txtSize: 15, txtColor: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const OfficersListScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(14),
                child: const TextWidget(
                    title: "  Save  ", txtSize: 15, txtColor: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
