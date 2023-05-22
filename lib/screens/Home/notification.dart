import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //sList<ItemLists> notifitems = [];
  //sbool? alrt;

  // @override
  // void initState() {
  //   super.initState();
  //   init();
  // }

  // init() {
  //   controller = context.read<authController>();
  //   controller.notif();
  // }

  // late authController controller;

  // int _counter = 0;
  // incrementCounter(authController controller) async {
  //   Timer.periodic(const Duration(seconds: 60), (Timer timer) {
  //     _counter++;
  //     StarlightNotificationService.show(
  //       StarlightNotification(
  //         title: 'Alert',
  //         body: 'Number of cases reached 20% of threshold',
  //         // payload: '{"name":"mg mg","age":20}',
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Container(
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      //bottom: 8.0,
                    ),
                    child: Divider(
                      thickness: 2,
                      color: btnColor,
                    ),
                  ),
                  SizedBox(
                    height: 940,
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: notifitems!.isEmpty
                          ? ShimmerNotificationView(20)
                          : loggedInUser!.role == "user"
                              ? ListView.builder(
                                  itemCount: notifitems!.length,
                                  itemBuilder: (context, index) {
                                    return loggedInUser!.user_id ==
                                                notifitems![index].user_id &&
                                            loggedInUser!.sec_id ==
                                                notifitems![index].sec_id
                                        ? Card(
                                            color: notifitems![index].percnt !=
                                                        null &&
                                                    notifitems![index].type!
                                                ? bkColor
                                                : null,
                                            child: ListTile(
                                              leading: notifitems![index].type!
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
                                                notifitems![index].percnt !=
                                                        null
                                                    ? "Cases reached ${notifitems![index].percnt}% in Sector: ${notifitems![index].sec_name}."
                                                    : "New case in your range.",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      notifitems![index].type!
                                                          ? btnColor
                                                          : txtColor,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "${notifitems![index].date}",
                                                //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: txtColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              trailing: TextButton(
                                                onPressed: () {},
                                                //  onPressed: incrementCounter(controller),
                                                child: Text(
                                                  "View Detail",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        notifitems![index].type!
                                                            ? btnColor
                                                            : txtColor,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                )
                              : ListView.builder(
                                  itemCount: notifitems!.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: notifitems![index].type!
                                          ? bkColor
                                          : null,
                                      child: ListTile(
                                        leading: notifitems![index].type!
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
                                          "Cases reached ${notifitems![index].percnt}% in Sector: ${notifitems![index].sec_name}.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: notifitems![index].type!
                                                ? btnColor
                                                : txtColor,
                                            fontSize: 15,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${notifitems![index].date}",
                                          //"${notifitems[index].datetime!.day}-${notifitems[index].datetime!.month}-${notifitems[index].datetime!.year}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: txtColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                        trailing: notifitems![index].type!
                                            ? TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Take Action",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        notifitems![index].type!
                                                            ? btnColor
                                                            : txtColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              )
                                            : TextButton(
                                                onPressed: () {},
                                                //  onPressed: incrementCounter(controller),
                                                child: Text(
                                                  "View Detail",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        notifitems![index].type!
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
