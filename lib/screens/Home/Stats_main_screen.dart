import 'package:dengue_tracing_application/Global/Screen_Paths.dart';

import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:badges/badges.dart' as badges;

class Stats_Main_Screen extends StatefulWidget {
  const Stats_Main_Screen({Key? key}) : super(key: key);

  @override
  State<Stats_Main_Screen> createState() => _Stats_Main_ScreenState();
}

class _Stats_Main_ScreenState extends State<Stats_Main_Screen> {
  @override
  Widget build(BuildContext context) {
    double bannerHeight = 200;
    return DefaultTabController(
      length: 2,
      child: Container(
        color: ScfColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: ScfColor,
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Date Picker Values
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 15,
                      left: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextWidget(
                          title: "Cases Report",
                          txtSize: 25,
                          txtColor: txtColor,
                        ),
                        const SizedBox(
                          width: 130,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: bkColor.withOpacity(0.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: badges.Badge(
                              badgeContent: Text(
                                loggedInUser!.role == "user"
                                    ? '$totalnotif'
                                    : '$sectorBasedCount',
                                style: TextStyle(
                                  color: ScfColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              showBadge: true,
                              ignorePointer: false,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen(),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.notifications,
                                  color: btnColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Divider(
                      thickness: 2,
                      color: btnColor,
                    ),
                  ),
                  //Date Picker Values
                  Padding(
                    padding: const EdgeInsets.only(
                      //top: 20.0,
                      right: 5,
                      left: 5,
                    ),
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      splashBorderRadius: BorderRadius.circular(25),
                      //indicatorWeight: 9,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black54,
                      //indicatorColor: Colors.amber,
                      indicator: BoxDecoration(

                          //shape: BoxShape.rectangle,
                          border: const Border.symmetric(),
                          borderRadius:
                              BorderRadius.circular(25), // Creates border
                          color: btnColor), //Change background color from here
                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        const Tab(
                          text: "My Sector",
                        ),
                        const Tab(
                          text: "All Sectors",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 7.0,
                      right: 5,
                    ),
                    child: SizedBox(
                      height: 850,
                      width: 500,
                      child: TabBarView(
                        children: [
                          StatsBySectorScreen(),
                          Stats_All_Sectors(),
                        ],
                      ),
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
