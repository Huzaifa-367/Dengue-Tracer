import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class TextWidget extends StatelessWidget {
//   final String message;

//   const TextWidget(
//       {Key? key,
//       //super.key,
//       required this.message,
//      })
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: GoogleFonts.gemunuLibre(
//         fontSize: txtSize,
//         fontWeight: FontWeight.bold,
//         color: txtColor,
//       ),
//     );
//   }
// }

// snackBar Widget
snackBar(context, String? message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: btnColor,
      content: Text(
        message!,
        style: GoogleFonts.gemunuLibre(
          fontWeight: FontWeight.w800,
          color: ScfColor,
          fontSize: 15,
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
