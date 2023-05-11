import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'constant.dart';

Widget expandablepage(context, String? btnTxt, List<Widget>? widgetColmunList) {
  return ButtonWidget(
    btnText: btnTxt!,
    onPress: () => DraggableMenu.open(
      context,
      DraggableMenu(
        color: ScfColor2,
        uiType: DraggableMenuUiType.softModern,
        expandable: true,
        fastDrag: true,
        minimizeBeforeFastDrag: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.72,
        maxHeight: MediaQuery.of(context).size.height * 0.36,
        child: ScrollableManager(
          enableExpandedScroll: true,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ...(widgetColmunList ?? []),

                  // Text(
                  //   "Sign Up",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w800,
                  //     color: txtColor,
                  //     fontSize: 25,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      barrier: true,
    ),
  );
}
