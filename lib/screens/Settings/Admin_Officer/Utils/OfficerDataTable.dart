import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';

import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Utils/EditOfficerPopUp.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_table_view/scrollable_table_view.dart';

class OffecerTable extends StatefulWidget {
  const OffecerTable({
    Key? key,
  }) : super(key: key);

  @override
  State<OffecerTable> createState() => _OffecerTableState();
}

class _OffecerTableState extends State<OffecerTable> {
  final PaginationController _paginationController = PaginationController(
    rowCount: many_products.length,
    rowsPerPage: 20,
  );
  // final PaginationController _simpleController = PaginationController(
  //   rowCount: products.length,
  //   rowsPerPage: products.length,
  // );
  @override
  Widget build(BuildContext context) {
    var columns = many_products.first.keys.toList();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ValueListenableBuilder(
                valueListenable: _paginationController,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      TextWidget(
                        title:
                            "${_paginationController.currentPage}  of   ${_paginationController.pageCount}",
                        txtSize: 15,
                        txtColor: txtColor,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Container(
                        height: 20,
                        width: 3,
                        color: btnColor,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _paginationController.currentPage <= 1
                                ? null
                                : () {
                                    _paginationController.previous();
                                  },
                            iconSize: 20,
                            splashRadius: 20,
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: _paginationController.currentPage <= 1
                                  ? Colors.black26
                                  : btnColor,
                            ),
                          ),
                          IconButton(
                            onPressed: _paginationController.currentPage >=
                                    _paginationController.pageCount
                                ? null
                                : () {
                                    _paginationController.next();
                                  },
                            iconSize: 20,
                            splashRadius: 20,
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: _paginationController.currentPage >=
                                      _paginationController.pageCount
                                  ? Colors.black26
                                  : btnColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          Expanded(
            child: ScrollableTableView(
              paginationController: _paginationController,
              columns: columns.map((column) {
                return TableViewColumn(
                  label: column,
                );
              }).toList(),
              rows: many_products.map(
                (product) {
                  return TableViewRow(
                    height: 60,
                    cells: columns.map(
                      (column) {
                        return TableViewCell(
                          child: !column.toString().contains("Edit")
                              ? Text(product[column].toString())
                              : IconButton(
                                  onPressed: () {
                                    getOfficerEditDialogue(
                                        TextEditingController(), context);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: btnColor,
                                  ),
                                ),

                          // child: Text(product[column].cast<String, String>()),
                        );
                      },
                    ).toList(),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

var many_products = [
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
  {
    "Id": "PR1000",
    "Name": "KFC Chicken",
    "Sectors": "consumable",
    "Email": "PC1002",
    "Edit": const Icon(Icons.edit),
  },
];
