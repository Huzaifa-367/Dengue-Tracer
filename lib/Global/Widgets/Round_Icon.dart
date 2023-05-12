import 'package:flutter/material.dart';

/// Creates a round icon with a background color.
// ignore: must_be_immutable
class RoundIcon extends StatelessWidget {
  IconData icon;
  Color backgroundColor;
  Color iconColor;
  double size;
  double padding;
  RoundIcon({
    Key? key,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.size = 24.0,
    this.padding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: size - padding,
      ),
    );
  }
}
