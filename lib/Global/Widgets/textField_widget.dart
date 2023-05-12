import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTxtField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  //IconData? preicon;
  String? label;
  IconData? siconn;
  TextInputType? keytype;

  InputTxtField({
    Key? key,
    //super.key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.siconn,
    this.keytype,
    this.label,
    //this.preicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //keyboardType: TextInputType.emailAddress,
      keyboardType: keytype,
      cursorColor: const Color.fromARGB(255, 245, 93, 93),
      controller: controller,
      validator: validator,
      obscureText: false,

      style: GoogleFonts.gemunuLibre(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        label: Text(
          label.toString(),
          style: GoogleFonts.gemunuLibre(
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 245, 93, 93),
            fontSize: 15,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromARGB(255, 242, 131, 131),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: Color.fromARGB(255, 245, 93, 93),
          ),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText,
        hintStyle: GoogleFonts.gemunuLibre(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 15,
        ),
        // prefixIcon: Icon(
        //   preicon,
        //   size: 20,
        //   color: const Color.fromARGB(255, 245, 93, 93),
        // ),
        suffixIcon: Icon(
          siconn,
          size: 20,
          color: const Color.fromARGB(255, 245, 93, 93),
        ),
      ),
    );
  }
}
