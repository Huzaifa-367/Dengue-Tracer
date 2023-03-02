import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Testings/expandable_datatable.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/officer_add_Screen.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/constant.dart';

class OfficersListScreen extends StatefulWidget {
  const OfficersListScreen({Key? key}) : super(key: key);

  @override
  State<OfficersListScreen> createState() => _OfficersListScreenState();
}

class _OfficersListScreenState extends State<OfficersListScreen> {
  TextEditingController text = TextEditingController();
  String dropdownValue = 'One';

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
            //leading: const Icon(Icons.add),
            //backgroundColor: btnColor,
            title: TextWidget(
                title: "All Health Officers", txtSize: 20, txtColor: txtColor),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     TextWidget(
                //         title: "Add New Officers",
                //         txtSize: 25,
                //         txtColor: txtColor),
                //     const SizedBox(
                //       width: 100,
                //     ),
                //     IconButton(
                //         onPressed: (() {
                //           Navigator.of(context).push(MaterialPageRoute(
                //             builder: (context) => const OfficerAddScreen(),
                //           ));
                //         }),
                //         icon: Icon(
                //           //size: 30,
                //           Icons.add_box_rounded,
                //           size: 30,
                //           color: btnColor,
                //         ))
                //   ],
                // ),
                Column(
                  children: [
                    //Divider(color: btnColor, thickness: 2),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Row(
                    //   children: [
                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //     TextWidget(
                    //         title: "All Health Officers",
                    //         txtSize: 20,
                    //         txtColor: txtColor),
                    //     const SizedBox(
                    //       width: 100,
                    //     ),
                    //     IconButton(
                    //         onPressed: (() {
                    //           getOfficerEditDialogue(text, context);
                    //         }),
                    //         icon: Icon(
                    //           //size: 30,
                    //           Icons.edit,
                    //           size: 30,
                    //           color: btnColor,
                    //         ))
                    //   ],
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: btnColor,
                      height: 690,
                      child: const Expandable_Table_Screen(),
                      //child: const OfficerTable(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
