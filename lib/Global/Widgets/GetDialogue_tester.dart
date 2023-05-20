import 'package:dengue_tracing_application/Global/Widgets/text_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

getDialogue(context, String? message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ScfColor,
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

getWidgetDialogue(context, List<Widget> children) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ScfColor,
      actions: children,
    ),
  );
}

class GetWidgetDialogue extends StatefulWidget {
  final List<Widget>? popupWidget;

  const GetWidgetDialogue({Key? key, required this.popupWidget})
      : super(key: key);

  @override
  _GetWidgetDialogueState createState() => _GetWidgetDialogueState();
}

class _GetWidgetDialogueState extends State<GetWidgetDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel_outlined,
                color: btnColor,
              ),
            ),
          ],
        ),
        ...(widget.popupWidget ?? []),
      ],
    );
  }
}
