import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

// snackBar Widget
snackBar(context, String? message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      elevation: 5,
      backgroundColor: btnColor,
      content: Text(
        message!,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: ScfColor,
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
