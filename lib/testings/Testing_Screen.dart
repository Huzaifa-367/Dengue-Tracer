import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/testings/DropDownListExample.dart';
import 'package:flutter/material.dart';

import '../Global/constant.dart';
import '../Json_Viewer_Screen.dart';
import 'Notify_screen.dart';

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
                  btnText: "///",
                  onPress: (() {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const DropDownListExample(),
                    //   ),
                    // ); // Notify notify = Notify();
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
