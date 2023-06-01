import 'package:dengue_tracing_application/Test_Screens/DropDownListExample.dart';
import 'package:dengue_tracing_application/Test_Screens/Json_Viewer_Screen.dart';
import 'package:dengue_tracing_application/Test_Screens/Notify_screen.dart';
import 'package:dengue_tracing_application/Test_Screens/Place_Picker.dart';
import 'package:dengue_tracing_application/Test_Screens/Slide_UP_Panel_Screen.dart';
import 'package:flutter/material.dart';

import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';

import 'Test_Screens/Card_Styles_Screen.dart';
import 'Test_Screens/Dragable_Navigation_Bar.dart';
import 'Test_Screens/ExpandAble_Manu_Screen.dart';
import 'package:dengue_tracing_application/Test_Screens/lib/flutter_staggered_animations.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'Test_Screens/Stats_MultiAxis.dart';

class Testings_Screen extends StatefulWidget {
  const Testings_Screen({super.key});

  @override
  State<Testings_Screen> createState() => _Testings_ScreenState();
}

class _Testings_ScreenState extends State<Testings_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          title: "Testings Screen",
          txtSize: 15,
          txtColor: txtColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "Json Viewer",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EndpointScreen(),
                      ),
                    );
                  }),
                ),
                ButtonWidget(
                  btnText: "DropDown List Example",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DropDownListExample(),
                      ),
                    ); // Notify notify = Notify();
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "Notify Screen",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Notify_Screen(),
                      ),
                    );
                  }),
                ),
                ButtonWidget(
                  btnText: "Picker Demo",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PickerDemo(),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "SlidingUp Panel",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SlidingUpPanelExample(),
                      ),
                    );
                  }),
                ),
                ButtonWidget(
                  btnText: "Expandable_Manu",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Expandable_Manu_Screen(),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "Staggered Animations",
                  onPress: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Staggered_animations(),
                      ),
                    );
                  }),
                ),
                ButtonWidget(
                  btnText: "Send SMS",
                  onPress: () async {
                    String message = "This is a test message!";
                    List<String> recipients = ["+923203608044"];

                    try {
                      String result = await sendSMS(
                        message: message,
                        recipients: recipients,
                        sendDirect: true,
                      );
                      print(result);
                    } catch (error) {
                      print(error);
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "Stats_MultiAxex",
                  onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Stats_MultiAxex(),
                      ),
                    );
                  },
                ),
                ButtonWidget(
                  btnText: "Drabable_Nav_Bar",
                  onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const Drabable_Navigation_Bar_Screen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  btnText: "Card_Styles_Screen",
                  onPress: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Card_Styles_Screen(),
                      ),
                    );
                  },
                ),
                ButtonWidget(
                  btnText: "MapLocPicker",
                  onPress: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const MapLocPicker(),
                    //  ),
                    // );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
