import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:flutter/material.dart';

getDialogue(context, String? message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(Icons.cancel),
            ),
          ],
        ),
        Center(
          child: TextWidget(
            title: "$message",
            txtSize: 30,
            txtColor: btnColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
