import 'dart:io';

import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:select2dot1/select2dot1.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_custom_selector/flutter_custom_selector.dart' as sector;

import 'DropDownController.dart';
import 'Search_Dropdown.dart';
export 'package:image_picker/image_picker.dart';

class Search_DropDown_Screen extends StatefulWidget {
  const Search_DropDown_Screen({super.key});

  @override
  State<Search_DropDown_Screen> createState() => _Search_DropDown_ScreenState();
}

// Initial Selected Value
String? filter = "fm";
// List of items in our dropdown menu

class _Search_DropDown_ScreenState extends State<Search_DropDown_Screen> {
  @override
  void initState() {
    super.initState();
    // getCommittees();
  }

  List<String>? comity;
  Map<String, int>? comityIds;
  int? selectedcomityId;

  DropDownController? dropDownController;

  Future<Map<String, int>> getCommitteesWithIds() async {
    final response = await http.get(Uri.parse('$api/Getcommetiee'));

    if (response.statusCode == 200) {
      final officersJson = jsonDecode(response.body) as List<dynamic>;
      final officers = officersJson.fold<Map<String, int>>({}, (map, officer) {
        final name = officer['title'];
        final userId = officer['com_id'];
        if (name != null && userId != null) {
          return map..[name] = userId;
        } else {
          return map;
        }
      });

      return officers;
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  // List<String> committeeTitles = [];

  // Future<void> getCommittees() async {
  //   try {
  //     var response = await Dio().get('$api/Getcommetiee');

  //     if (response.statusCode == 200) {
  //       if (response.data != 'false') {
  //         List<Map<String, dynamic>> committees =
  //             List<Map<String, dynamic>>.from(response.data);

  //         setState(() {
  //           committeeTitles = committees
  //               .map((committee) => committee["title"].toString())
  //               .toList();
  //         });
  //       } else {
  //         // Handle API error or empty response
  //       }
  //     } else {
  //       // Handle API error
  //     }
  //   } catch (error) {
  //     // Handle network or other errors
  //   }
  // }

  List<String>? users;
  Map<String, int>? usersIds;
  int? selectedUserId;
  SingleCategoryModel? stdsCategory; // Initialize stdsCategory
  SingleCategoryModel? userCategory;
  fetchUsersWithIds(String? usertype) async {
    final response =
        await http.get(Uri.parse('$api/GetReportedBy?usertype=$usertype'));

    if (response.statusCode == 200) {
      final officersJson = jsonDecode(response.body) as List<dynamic>;

      userCategory = SingleCategoryModel(
        nameCategory: usertype == 'fm'
            ? 'Faculty Mem'
            : usertype == 'nfm'
                ? 'Non faculty'
                : 'Student',
        singleItemCategoryList: officersJson
            .map((e) => SingleItemCategoryModel(
                  value: e['u_id'].toString(),
                  extraInfoSingleItem: e['name'],
                  nameSingleItem: e['name'],
                ))
            .toList(),
      );

      // Map<String, int> usersWithIds = {};
      // category.singleItemCategoryList.forEach((item) {
      //   final name = item.nameSingleItem;
      //   final value = item.value;
      //   if (name != null && value != null) {
      //     usersWithIds[name] = int.parse(value);
      //   }
      // });

//      stdsCategory = category; // Assign the value to stdsCategory

      return stdsCategory == null ? null : stdsCategory!;
    } else {
      throw Exception('Failed to fetch users');
    }
  }

//
//
//
  List<String>? stds;

  int? selectedstdId;
  fetchstdsWithIds(String? usertype) async {
    final response =
        await http.get(Uri.parse('$api/GetReportedBy?usertype=$usertype'));

    if (response.statusCode == 200) {
      final officersJson = jsonDecode(response.body) as List<dynamic>;

      stdsCategory = SingleCategoryModel(
        nameCategory: usertype == 'fm'
            ? 'Faculty Mem'
            : usertype == 'nfm'
                ? 'Non faculty'
                : 'Student',
        singleItemCategoryList: officersJson
            .map((e) => SingleItemCategoryModel(
                  value: e['u_id'].toString(),
                  extraInfoSingleItem: e['name'],
                  nameSingleItem: e['username'],
                ))
            .toList(),
      );

      // Map<String, int> usersWithIds = {};
      // category.singleItemCategoryList.forEach((item) {
      //   final name = item.nameSingleItem;
      //   final value = item.value;
      //   if (name != null && value != null) {
      //     usersWithIds[name] = int.parse(value);
      //   }
      // });

//      stdsCategory = category; // Assign the value to stdsCategory

      return stdsCategory == null ? null : stdsCategory!;
    } else {
      throw Exception('Failed to fetch officers');
    }
  }

  File? imageFile;

  TextEditingController test3 = TextEditingController();
  TextEditingController test1 = TextEditingController();
  TextEditingController des_con = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dropDownController = context.read<DropDownController>();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: TextWidget(
              title: "Reported By",
              txtSize: 25,
              txtColor: txtColor,
            ),
          ),
          //backgroundColor: Colors.amber,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder(
                        future: fetchUsersWithIds(filter),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            // usersIds = snapshot.data;
                            // users = usersIds!.keys.toList();

                            return GestureDetector(
                              onTap: () async {
                                //
                                //
                              },
                              child: CustomSelect2dot1(
                                avatarInSingleSelect: true,
                                extraInfoInDropdown: false,
                                isReortedby: true,
                                extraInfoInSingleSelect: false,
                                title: 'Select',
                                scrollController: ScrollController(),
                                data:
                                    userCategory != null ? [userCategory!] : [],
                                isMultiSelect: false,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error fetching users data');
                          } else {
                            return const SizedBox(); // Placeholder widget when there is no data or error
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FutureBuilder(
                        future: fetchstdsWithIds("std"),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // stdsIds = snapshot.data;
                            // stds = stdsIds!.keys.toList();
                            return CustomSelect2dot1(
                              avatarInSingleSelect: true,
                              extraInfoInDropdown: true,
                              isReortedby: false,
                              extraInfoInSingleSelect: false,
                              title: 'Select',
                              scrollController: ScrollController(),
                              data: stdsCategory == null ? [] : [stdsCategory!],
                              isMultiSelect: false,
                            );
                          } else if (snapshot.hasError) {
                            return const Text('Error fetching officers data');
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
