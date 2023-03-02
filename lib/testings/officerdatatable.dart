import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../screens/Settings/Admin_Officer/Utils/EditOfficerPopUp.dart';

/// The home page of the application which hosts the datagrid.
class OfficerTable extends StatefulWidget {
  static late BuildContext context;

  /// Creates the home page.
  const OfficerTable({Key? key}) : super(key: key);

  @override
  _OfficerTableState createState() => _OfficerTableState();
}

class _OfficerTableState extends State<OfficerTable> {
  List<Employee> employees = <Employee>[];
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData: employees);
  }

  @override
  Widget build(BuildContext context) {
    OfficerTable.context = context;
    return SingleChildScrollView(
      child: SfDataGrid(
        allowPullToRefresh: true,
        //rowsPerPage: 10,
        //rowsPerPage: 2,
        //allowColumnsResizing: true,
        isScrollbarAlwaysShown: true,
        source: employeeDataSource,
        columnWidthMode: ColumnWidthMode.fitByCellValue,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: 'name',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Name'))),
          GridColumn(
              allowEditing: true,
              allowFiltering: true,
              columnName: 'Sectors',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Sectors',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'Email',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Email'))),
          GridColumn(
              allowEditing: true,
              columnName: 'Edit',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Edit'))),
        ],
      ),
    );
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', "gfdgf@gmail.com",
          const IconButton(onPressed: null, icon: Icon(Icons.edit))),
      Employee(10002, 'Kathryn', 'Manager', "tfty@gmail.com",
          const IconButton(onPressed: null, icon: Icon(Icons.edit))),
      Employee(10003, 'Lara', 'Developer', "ytfytf@gmail.com",
          const IconButton(onPressed: null, icon: Icon(Icons.edit))),
      Employee(10004, 'Michael', 'Designer', "gfhg@gmail.com",
          const IconButton(onPressed: null, icon: Icon(Icons.edit))),
      Employee(
        10005,
        'Martin',
        'Developer',
        "gdfs@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      ),
      Employee(
        10006,
        'Newberry',
        'Developer',
        "ghf@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      ),
      Employee(
        10007,
        'Balnc',
        'Developer',
        "bvc@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      ),
      Employee(
        10008,
        'Perry',
        'Developer',
        "trere@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      ),
      Employee(
        10009,
        'Gable',
        'Developer',
        "dfasd@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      ),
      Employee(
        10010,
        'Grimes',
        'Developer',
        "oiy@gmail.com",
        const IconButton(onPressed: null, icon: Icon(Icons.edit)),
      )
    ];
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.sectors, this.email, this.edit);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String sectors;

  /// Salary of an employee.
  final String email;
  final IconButton edit;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(columnName: 'Sectors', value: e.sectors),
              DataGridCell<String>(columnName: 'Email', value: e.email),
              DataGridCell<IconButton>(columnName: "Edit", value: e.edit)
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: !e.value.toString().contains('IconButton')
            ? Text(e.value.toString())
            : IconButton(
                onPressed: () {
                  getOfficerEditDialogue(
                      TextEditingController(), OfficerTable.context);
                },
                icon: const Icon(Icons.edit)),
      );
    }).toList());
  }
}
