import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double txtSize;
  final Color txtColor;
  final Type? onpress;
  const TextWidget(
      {Key? key,
      //super.key,
      required this.title,
      required this.txtSize,
      required this.txtColor,
      this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: txtSize,
        fontWeight: FontWeight.bold,
        color: txtColor,
      ),
      // return Text(
      // title,
      // style: GoogleFonts.gemunuLibre(
      //   fontSize: txtSize,
      //   fontWeight: FontWeight.bold,
      //   color: txtColor,
      // ),
    );
  }
}
