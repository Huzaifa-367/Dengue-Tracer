import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Officer/Location_Verify_Map.dart';

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

  int? sec_id;

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
                                    return Card(
                                      color: notifitems![index].percnt !=
                                                  null &&
                                              notifitems![index].percnt! >= 75
                                          ? bkColor
                                          : null,
                                      child: ListTile(
                                        leading:
                                            notifitems![index].percnt != null
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
                                          notifitems![index].percnt != null
                                              ? "Cases reached ${notifitems![index].percnt}% in Sector: ${notifitems![index].sec_name}."
                                              : "New case in your range.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: notifitems![index].percnt !=
                                                    null
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
                                                  notifitems![index].percnt !=
                                                          null
                                                      ? btnColor
                                                      : txtColor,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
                                        trailing: notifitems![index].type! ==
                                                true
                                            ? TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Location_Verify_Map(),
                                                      //builder: (context) => const MapScreen(),
                                                    ),
                                                  );
                                                  // () async {
                                                  //   var LocId =
                                                  //       await Navigator.of(
                                                  //               context)
                                                  //           .push(
                                                  //     MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const Location_Verify_Map(),
                                                  //       //builder: (context) => const MapScreen(),
                                                  //     ),
                                                  //   );
                                                  //   setState(() {
                                                  //     final LocSecid =
                                                  //         LocId.split('-');
                                                  //     //home_loccont.text = LocSecid[0];
                                                  //     sec_id = LocSecid[1] ==
                                                  //             "You,re not in our Sectors."
                                                  //         ? null
                                                  //         : int.parse(
                                                  //             LocSecid[1]);
                                                  //   });

                                                  //   //builder: (context) => const Mapp_test()));
                                                  //   // textController.text =
                                                  //   //     "${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}";
                                                  //   // Navigator.of(context).pop();
                                                  // };
                                                },
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
