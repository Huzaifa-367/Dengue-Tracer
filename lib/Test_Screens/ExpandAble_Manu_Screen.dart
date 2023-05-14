import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:flutter/material.dart';

class Expandable_Manu_Screen extends StatefulWidget {
  const Expandable_Manu_Screen({Key? key}) : super(key: key);

  @override
  State<Expandable_Manu_Screen> createState() => _Expandable_Manu_ScreenState();
}

class _Expandable_Manu_ScreenState extends State<Expandable_Manu_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9FB373),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 100.0),
        children: [
          Center(
              child: SizedBox(
            height: 400.0,
            width: 290.0,
            child: Stack(
              children: [
                Positioned(
                  top: 23.0,
                  right: 23.0,
                  left: 23.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: ExpandableMenu(
                      width: 46.0,
                      height: 46.0,
                      items: [
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                        Container(),
                      ],
                    )),
              ],
            ),
          )),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: SizedBox(
            height: 200.0,
            width: 200.0,
            child: Stack(
              children: [
                Positioned(
                  top: 20.0,
                  right: 20.0,
                  left: 20.0,
                  bottom: 0.0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    top: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: ExpandableMenu(
                      width: 40.0,
                      height: 40.0,
                      items: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.access_alarm,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.accessible_forward,
                          color: Colors.white,
                        ),
                        Icon(
                          Icons.accessibility_new_sharp,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ],
            ),
          )),
          const SizedBox(
            height: 40,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                height: 200.0,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20.0,
                      right: 20.0,
                      left: 20.0,
                      bottom: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: ExpandableMenu(
                          width: 40.0,
                          height: 40.0,
                          backgroundColor: Colors.black,
                          iconColor: Colors.amber,
                          itemContainerColor: Colors.amber,
                          items: [
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                            Container(),
                          ],
                        )),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
