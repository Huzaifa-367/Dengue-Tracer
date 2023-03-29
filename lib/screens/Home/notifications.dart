// import 'package:dengue_tracing_application/Global/constant.dart';
// import 'package:dengue_tracing_application/model/NOTIFICATION/notifmodel.dart';
// import 'package:flutter/material.dart';

// class NotifScreen extends StatefulWidget {
//   const NotifScreen({Key? key}) : super(key: key);

//   @override
//   State<NotifScreen> createState() => _NotifScreenState();
// }

// class _NotifScreenState extends State<NotifScreen> {
//   bool? alrt;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: ScfColor,
//           appBar: AppBar(
//             backgroundColor: ScfColor,
//             title: Text(
//               "Notifications",
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: txtColor,
//                 fontSize: 25,
//               ),
//             ),
//           ),

//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: notifitems.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   color: notifitems[index].alert! ? bkColor : null,
//                   //                           <-- Card widget
//                   child: ListTile(
//                     leading: notifitems[index].alert!
//                         ? Icon(
//                             Icons.warning,
//                             color: btnColor,
//                             size: 35,
//                           )
//                         : Icon(
//                             Icons.campaign_rounded,
//                             color: btnColor,
//                             size: 35,
//                           ),
//                     title: Text(
//                       "${notifitems[index].title}",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         color: notifitems[index].alert! ? btnColor : txtColor,
//                         fontSize: 15,
//                       ),
//                     ),
//                     subtitle: Text(
//                       "${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: txtColor,
//                         fontSize: 12,
//                       ),
//                     ),
//                     trailing: notifitems[index].alert!
//                         ? TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               "Take Action",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: notifitems[index].alert!
//                                     ? btnColor
//                                     : txtColor,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           )
//                         : TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               "View Detail",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w400,
//                                 color: notifitems[index].alert!
//                                     ? btnColor
//                                     : txtColor,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           // ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/NOTIFICATION/notifmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  List<ItemLists> notifitems = [];
  bool? alrt;

  Future<List<ItemLists>> _fetchNotificationData() async {
    final response = await http.get(Uri.parse("$ip/ShowallNotifications"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ItemLists> tempList = [];

      for (var item in data) {
        ItemLists newItem = ItemLists(
          title: item['title'],
          //description: item['description'],
          alert: item['type'],
          date: item['date'].toString().split('T')[0],
        );
        tempList.add(newItem);
      }

      setState(() {
        notifitems = tempList;
      });

      return notifitems;
    } else {
      throw Exception('Failed to load notification data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotificationData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          appBar: AppBar(
            backgroundColor: ScfColor,
            title: Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: txtColor,
                fontSize: 25,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: notifitems.length,
              itemBuilder: (context, index) {
                return Card(
                  color: notifitems[index].alert! ? bkColor : null,
                  child: ListTile(
                    leading: notifitems[index].alert!
                        ? Icon(
                            Icons.warning,
                            color: btnColor,
                            size: 35,
                          )
                        : Icon(
                            Icons.campaign_rounded,
                            color: btnColor,
                            size: 35,
                          ),
                    title: Text(
                      "${notifitems[index].title}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: notifitems[index].alert! ? btnColor : txtColor,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      "${notifitems[index].date}",
                      //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: txtColor,
                        fontSize: 12,
                      ),
                    ),
                    trailing: notifitems[index].alert!
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                              "Take Action",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: notifitems[index].alert!
                                    ? btnColor
                                    : txtColor,
                                fontSize: 13,
                              ),
                            ),
                          )
                        : TextButton(
                            onPressed: () {},
                            child: Text(
                              "View Detail",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: notifitems[index].alert!
                                    ? btnColor
                                    : txtColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
