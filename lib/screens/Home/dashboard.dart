import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/screens/Map/Temporal_Map-Backup.dart';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

const List<TabItem> items = [
  TabItem(
    //count: ButtonBar(),
    icon: Icons.map_rounded,
    title: 'Map',
  ),
  // TabItem(
  //   count: ButtonBar(),
  //   icon: Icons.map_rounded,
  //   title: 'Temp_Map',
  // ),
  TabItem(
    icon: Icons.graphic_eq,
    title: 'Stats',
  ),
  TabItem(
    icon: Icons.speaker,
    title: 'Awareness',
  ),
  TabItem(
    icon: Icons.person,
    title: 'profile',
  ),
];

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int visit = 0;
  double height = 30;

  int selectedindex = 0;
  List<Widget> screens = [
    //const CasesMap(),
    //const DengueMap(),
    const Temporal_Map_Backup(),
    loggedInUser!.role == "user"
        ? const Stats_Main_Screen()
        : const Stats_All_admin_officer(),
    const Awareness(),
    const Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          body: screens[selectedindex],
          bottomNavigationBar: SizedBox(
            child: BottomBarInspiredInside(
              items: items,
              backgroundColor: btnColor,
              color: Colors.white,
              colorSelected: btnColor,
              indexSelected: visit,
              onTap: (int index) => setState(() {
                visit = index;
                selectedindex = index;
              }),
              animated: true,
              chipStyle: const ChipStyle(
                isHexagon: true,
                convexBridge: true,
                btkColor: Colors.red,
              ),
              itemStyle: ItemStyle.hexagon,
            ),
          ),
        ),
      ),
    );
  }
}
