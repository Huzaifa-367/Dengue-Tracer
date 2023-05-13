// s
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';

class EndpointScreen extends StatefulWidget {
  const EndpointScreen({super.key});

  @override
  _EndpointScreenState createState() => _EndpointScreenState();
}

class _EndpointScreenState extends State<EndpointScreen> {
  final TextEditingController _endpointController = TextEditingController();
  String _jsonData = '';
  List<Map<String, dynamic>> _tableData = [];

  Future<void> _fetchData() async {
    try {
      Response response = await Dio().get("$ip/${_endpointController.text}");
      setState(() {
        _jsonData = const JsonEncoder.withIndent('    ').convert(response.data);
        _tableData = List<Map<String, dynamic>>.from(response.data);
      });
    } catch (e) {
      print(e);
    }
  }

  _clearData() {
    setState(() {
      _tableData = [];
      _jsonData = '';
    });
  }

  List<Map<String, dynamic>> flatData = [];
  List<Map<String, dynamic>> _flattenJsonData(dynamic jsonData) {
    for (var item in jsonData) {
      Map<String, dynamic> flatItem = {};
      item.forEach((key, value) {
        if (value is Map) {
          flatItem.addAll(_flattenJsonData(value).first);
        } else if (value is List) {
          flatItem[key] = value.join(', ');
        } else {
          flatItem[key] = value;
        }
      });
      flatData.add(flatItem);
    }
    return flatData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON Viewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _endpointController,
              decoration: const InputDecoration(
                labelText: 'Endpoint',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _fetchData,
                  child: const Text('Fetch Data'),
                ),
                ElevatedButton(
                  onPressed: _clearData,
                  child: const Text('Clear Data'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ScfColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _tableData.isEmpty
                      ? SingleChildScrollView(
                          child: HighlightView(
                            _jsonData,
                            language: 'json',
                            theme: githubTheme,
                            padding: const EdgeInsets.all(12),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: _tableData.first.keys
                                  .map((key) => DataColumn(label: Text(key)))
                                  .toList(),
                              rows: _tableData
                                  .map((item) => DataRow(
                                      cells: item.entries
                                          .map((entry) => DataCell(Text(
                                                '${entry.value}',
                                                overflow: TextOverflow.ellipsis,
                                              )))
                                          .toList()))
                                  .toList(),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
