import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/NOTIFICATION/notifmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/NotificationController.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  List<ItemLists> notifitems = [];
  bool? alrt;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    controller = context.read<authController>();
    controller.notif();
  }

  late authController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          appBar: AppBar(
            backgroundColor: ScfColor,
            title: Row(
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: txtColor,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<authController>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: controller.notifitems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: controller.notifitems[index].alert!
                            ? bkColor
                            : null,
                        child: ListTile(
                          leading: controller.notifitems[index].alert!
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
                            "${controller.notifitems[index].title}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: controller.notifitems[index].alert!
                                  ? btnColor
                                  : txtColor,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            "${controller.notifitems[index].date}",
                            //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: txtColor,
                              fontSize: 12,
                            ),
                          ),
                          trailing: controller.notifitems[index].alert!
                              ? TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Take Action",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: controller.notifitems[index].alert!
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
                                      color: controller.notifitems[index].alert!
                                          ? btnColor
                                          : txtColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
