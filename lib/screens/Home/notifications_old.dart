// import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:starlight_notification/starlight_notification.dart';

// import '../../Controller/NotificationController.dart';

// class NotifScreen extends StatefulWidget {
//   const NotifScreen({Key? key}) : super(key: key);

//   @override
//   State<NotifScreen> createState() => _NotifScreenState();
// }

// class _NotifScreenState extends State<NotifScreen> {
//   //sList<ItemLists> notifitems = [];
//   //sbool? alrt;

//   @override
//   void initState() {
//     super.initState();
//     init();
//   }

//   init() {
//     controller = context.read<authController>();
//     controller.notif();
//   }

//   late authController controller;

//   int _counter = 0;
//   incrementCounter(authController controller) async {
//     Timer.periodic(const Duration(seconds: 60), (Timer timer) {
//       _counter++;
//       StarlightNotificationService.show(
//         StarlightNotification(
//           title: 'Alert',
//           body: 'Number of cases reached 20% of threshold',
//           // payload: '{"name":"mg mg","age":20}',
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AutoRefresh(
//       duration: const Duration(milliseconds: 2000),
//       child: Container(
//         color: ScfColor,
//         child: SafeArea(
//           child: Scaffold(
//             backgroundColor: ScfColor,
//             appBar: AppBar(
//               backgroundColor: ScfColor,
//               title: Row(
//                 children: [
//                   Text(
//                     "Notifications",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: txtColor,
//                       fontSize: 25,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 940,
//                     width: 500,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Consumer<authController>(
//                         builder: (context, value, child) {
//                           // return ShimmerPro.generated(
//                           //   light: ShimmerProLight.lighter,
//                           //   scaffoldBackgroundColor: Colors.transparent,
//                           //   child: Column(
//                           //     children: [
//                           //       Row(
//                           //         children: [
//                           //           ShimmerPro.sized(
//                           //             light: ShimmerProLight.lighter,
//                           //             scaffoldBackgroundColor: bkColor,
//                           //             height: 50,
//                           //             width: 50,
//                           //           ),
//                           //           ShimmerPro.text(
//                           //             maxLine: 2,
//                           //             alignment: Alignment.center,
//                           //             light: ShimmerProLight.lighter,
//                           //             scaffoldBackgroundColor: bkColor,
//                           //             width: 170,
//                           //             textSize: 10,
//                           //           ),
//                           //           ShimmerPro.sized(
//                           //             borderRadius: 25,
//                           //             light: ShimmerProLight.lighter,
//                           //             scaffoldBackgroundColor: bkColor,
//                           //             height: 35,
//                           //             width: 50,
//                           //           ),
//                           //         ],
//                           //       ),
//                           //       SizedBox(
//                           //           height: 350,
//                           //           width: 450,
//                           //           child: ShimmerNotificationView(20)),
//                           //     ],
//                           //   ),
//                           // );

//                           return controller.notifitems.isEmpty
//                               ? ShimmerNotificationView(20)
//                               : ListView.builder(
//                                   itemCount: controller.notifitems.length,
//                                   itemBuilder: (context, index) {
//                                     return Card(
//                                       color: controller.notifitems[index].alert!
//                                           ? bkColor
//                                           : null,
//                                       child: ListTile(
//                                         leading:
//                                             controller.notifitems[index].alert!
//                                                 ? Icon(
//                                                     Icons.warning,
//                                                     color: btnColor,
//                                                     size: 35,
//                                                   )
//                                                 : Icon(
//                                                     Icons.campaign_rounded,
//                                                     color: btnColor,
//                                                     size: 35,
//                                                   ),
//                                         title: Text(
//                                           "${controller.notifitems[index].title}",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w600,
//                                             color: controller
//                                                     .notifitems[index].alert!
//                                                 ? btnColor
//                                                 : txtColor,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                         subtitle: Text(
//                                           "${controller.notifitems[index].date}",
//                                           //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             color: txtColor,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                         trailing: controller
//                                                 .notifitems[index].alert!
//                                             ? TextButton(
//                                                 onPressed: () {},
//                                                 child: Text(
//                                                   "Take Action",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: controller
//                                                             .notifitems[index]
//                                                             .alert!
//                                                         ? btnColor
//                                                         : txtColor,
//                                                     fontSize: 13,
//                                                   ),
//                                                 ),
//                                               )
//                                             : TextButton(
//                                                 onPressed: () {},
//                                                 //  onPressed: incrementCounter(controller),
//                                                 child: Text(
//                                                   "View Detail",
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w400,
//                                                     color: controller
//                                                             .notifitems[index]
//                                                             .alert!
//                                                         ? btnColor
//                                                         : txtColor,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ),
//                                       ),
//                                     );
//                                   },
//                                 );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
