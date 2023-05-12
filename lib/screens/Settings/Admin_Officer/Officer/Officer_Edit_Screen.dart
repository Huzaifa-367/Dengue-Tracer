import 'package:dengue_tracing_application/Global/Widgets/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/Widgets/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/Widgets/text_widget.dart';
import 'package:dengue_tracing_application/model/OFFICER/Officer_API.dart';

import 'package:flutter/material.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart' as sector;
import 'package:http/http.dart' as http;
import 'dart:convert';

class Officer_Edit_Screen extends StatefulWidget {
  const Officer_Edit_Screen({Key? key}) : super(key: key);

  @override
  State<Officer_Edit_Screen> createState() => _Officer_Edit_ScreenState();
}

class _Officer_Edit_ScreenState extends State<Officer_Edit_Screen> {
  TextEditingController namecont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  TextEditingController passwordcont2 = TextEditingController();
  bool isVisible = true;
  String role = 'officer';

  List<String>? officers;
  Map<String, int>? officerIds;
  int? selectedOfficerId;

  Future<Map<String, int>> fetchOfficersWithIds() async {
    final response = await http.get(Uri.parse('$ip/getofficers'));

    if (response.statusCode == 200) {
      final officersJson = jsonDecode(response.body) as List<dynamic>;
      final officers = officersJson.fold<Map<String, int>>({}, (map, officer) {
        final name = officer['name'];
        final userId = officer['user_id'];
        if (name != null && userId != null) {
          return map..[name] = userId;
        } else {
          return map;
        }
      });

      return officers;
    } else {
      throw Exception('Failed to fetch officers');
    }
  }

  List<String>? sectors;
  List<String>? selectedDataString;
  int? selectedSectorId;

  Future<List<String>> fetchSectors() async {
    final response = await http.get(Uri.parse('$ip/GetallSectors'));
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
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: btnColor,
            title: TextWidget(
              title: "Edit Health Officer",
              txtSize: 20,
              txtColor: txtColor,
            ),
          ),
          //backgroundColor: Colors.amber,

          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(
                    color: btnColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextWidget(
                    title: "Select Officer",
                    txtSize: 15,
                    txtColor: txtColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder<Map<String, int>>(
                      future: fetchOfficersWithIds(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          officerIds = snapshot.data;
                          officers = officerIds!.keys.toList();
                          return sector.CustomSingleSelectField<String>(
                            title: 'Officers',
                            items: officers!,
                            onSelectionDone: (value) {
                              final selectedOfficerId =
                                  officerIds![value as String];
                              setState(() {
                                this.selectedOfficerId = selectedOfficerId;
                              });
                            },
                            itemAsString: (item) => item.toString(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text('Error fetching officers data');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    title: "Select Sector",
                    txtSize: 15,
                    txtColor: txtColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder<List<String>>(
                      future: fetchSectors(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          sectors = snapshot.data;
                          return sector.CustomSingleSelectField<String>(
                            title: "Sectors",
                            items: sectors!,
                            //enableAllOptionSelect: true,
                            onSelectionDone: (dynamic value) {
                              int selectedSectorIndex =
                                  sectors!.indexOf(value as String);
                              selectedSectorId = selectedSectorIndex != -1
                                  ? selectedSectorIndex + 1
                                  : null; // assuming sector IDs start from 1

                              // if (selectedSectorId != null) {
                              //   // call the C# API
                              // }
                            },

                            itemAsString: (item) => item.toString(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Error fetching sectors data");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ButtonWidget(
                        btnText: "Save",
                        onPress: (() async {
                          if (selectedSectorId != null &&
                              selectedOfficerId != null) {
                            // User u = User();
                            // u.role = role;
                            // u.name = namecont.text;
                            // u.email = emailcont.text;
                            // u.phone_number = phonecont.text;
                            // u.password = passwordcont.text;
                            // u.home_location = "";
                            // u.sec_id = selectedSectorId;
                            // selectedOfficerId

                            await UpdateOfficerSector(
                              selectedSectorId,
                              selectedOfficerId,
                              context,
                            );
                          } else {
                            snackBar(context,
                                "Please Select Values Form Both Sections.");
                          }
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
