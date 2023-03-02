// import 'package:dengue_tracing_application/screens/Map/map1.dart';
// import 'package:dengue_tracing_application/screens/Map/map_circles.dart';
// import 'package:dengue_tracing_application/screens/Map/map_find_friends.dart';
// import 'package:flutter/material.dart';

// import 'package:dengue_tracing_application/Global/constant.dart';

// class TestingScreen extends StatefulWidget {
//   const TestingScreen({Key? key}) : super(key: key);

//   @override
//   State<TestingScreen> createState() => _TestingScreenState();
// }

// class _TestingScreenState extends State<TestingScreen> {
//   DateTime? startDate;
//   DateTime? endDate;
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: SafeArea(
//         child: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.only(
//               top: 30.0,
//               right: 15,
//               left: 15,
//             ),
//             child: Column(
//               children: [
//                 TabBar(
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   splashBorderRadius: BorderRadius.circular(5),
//                   //indicatorWeight: 9,
//                   unselectedLabelColor: Colors.black54,
//                   //indicatorColor: Colors.amber,
//                   indicator: BoxDecoration(

//                       //shape: BoxShape.rectangle,
//                       border: const Border.symmetric(),
//                       borderRadius: BorderRadius.circular(5), // Creates border
//                       color: btnColor), //Change background color from here
//                   // ignore: prefer_const_literals_to_create_immutables
//                   tabs: [
//                     const Tab(
//                       text: "Mian",
//                     ),
//                     const Tab(
//                       text: "circle",
//                     ),
//                     // const Tab(
//                     //   text: "search",
//                     // ),
//                     const Tab(
//                       text: "friends",
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const SizedBox(
//                   height: 600,
//                   width: 500,
//                   child: TabBarView(children: [
//                     MapMain(),
//                     MapCircles(),
//                     //MapSearchScreen(),
//                     MapFindFriends()
//                   ]),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
