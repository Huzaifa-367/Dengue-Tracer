import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/officer_view.dart';
import 'package:dengue_tracing_application/testings/Tables/expandable_datatable.dart';
import 'package:flutter/material.dart';

class OfficersList_Screen extends StatefulWidget {
  const OfficersList_Screen({Key? key}) : super(key: key);

  @override
  State<OfficersList_Screen> createState() => _OfficersList_ScreenState();
}

class _OfficersList_ScreenState extends State<OfficersList_Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.white,
        child: Scaffold(
          appBar: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            splashBorderRadius: BorderRadius.circular(25),
            padding: const EdgeInsets.only(
              top: 5,
              left: 8,
              right: 8,
              bottom: 0,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black54,
            //indicatorColor: Colors.amber,
            indicator: BoxDecoration(
                //shape: BoxShape.rectangle,
                border: const Border.symmetric(),
                borderRadius: BorderRadius.circular(25), // Creates border
                color: btnColor), //Change background color from here
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const Tab(
                height: 50,
                text: "Symptoms",
              ),
              const Tab(
                height: 50,
                text: "Preventions",
              ),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: TabBarView(
              // clipBehavior: Clip.antiAlias,
              children: [
                OfficersListScreen(),
                Expandable_Table_Screen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
