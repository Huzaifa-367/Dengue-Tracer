import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/material.dart';

class InputTxtFieldConatain extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  //final String? Function(String?)? validator;

  //IconData? preicon;
  String? label;
  IconData? siconn;
  TextInputType? keytype;

  InputTxtFieldConatain({
    Key? key,
    //super.key,
    required this.hintText,
    required this.controller,
    //required this.validator,
    this.siconn,
    this.keytype,
    this.label,
    //this.preicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.03),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 15, bottom: 5, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$label",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color(0xff67727d)),
              ),
              TextField(
                keyboardType: keytype,
                controller: controller,
                cursorColor: black,
                enableIMEPersonalizedLearning: true,
                enableSuggestions: true,

                // validator: validator,
                obscureText: false,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w500, color: black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  prefixIconColor: black,
                  hintText: hintText,
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    siconn,
                    size: 20,
                    color: const Color.fromARGB(255, 245, 93, 93),
                  ),
                ),
              ),
            ],
          ),
        ));
//     return TextFormField(
//       //keyboardType: TextInputType.emailAddress,
//       keyboardType: keytype,
//       cursorColor: const Color.fromARGB(255, 245, 93, 93),
//       controller: controller,
//       validator: validator,
//       obscureText: false,

//       style: GoogleFonts.gemunuLibre(
//         color: const Color.fromARGB(255, 0, 0, 0),
//         fontSize: 15,
//       ),
//       decoration: InputDecoration(
//         label: Text(
//           label.toString(),
//           style: GoogleFonts.gemunuLibre(
//             fontWeight: FontWeight.w600,
//             color: const Color.fromARGB(255, 245, 93, 93),
//             fontSize: 15,
//           ),
//         ),
//         enabledBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 2,
//             color: Color.fromARGB(255, 242, 131, 131),
//           ),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             width: 3,
//             color: Color.fromARGB(255, 245, 93, 93),
//           ),
//         ),
//         border: const OutlineInputBorder(),
//         hintText: hintText,
//         hintStyle: GoogleFonts.gemunuLibre(
//           fontWeight: FontWeight.w400,
//           color: Colors.black,
//           fontSize: 15,
//         ),
//         // prefixIcon: Icon(
//         //   preicon,
//         //   size: 20,
//         //   color: const Color.fromARGB(255, 245, 93, 93),
//         // ),
//         suffixIcon: Icon(
//           siconn,
//           size: 20,
//           color: const Color.fromARGB(255, 245, 93, 93),
//         ),
//       ),
//     );
//   }
// }

//  Container(
//               width = double.infinity,
//               margin = const EdgeInsets.symmetric(horizontal: 25),
//               decoration = BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: grey.withOpacity(0.03),
//                       spreadRadius: 10,
//                       blurRadius: 3,
//                       // changes position of shadow
//                     ),
//                   ]),
//               child = Padding(
//                 padding: const EdgeInsets.only(
//                     left: 20, top: 15, bottom: 5, right: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Email Address",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 13,
//                           color: Color(0xff67727d)),
//                     ),
//                     TextField(
//                       controller: _email,
//                       cursorColor: black,
//                       style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w500,
//                           color: black),
//                       decoration: const InputDecoration(
//                           prefixIcon: Icon(Icons.email_outlined),
//                           prefixIconColor: black,
//                           hintText: "Email",
//                           border: InputBorder.none),
//                     ),
//                   ],
//                 ),
//               )),
  }
}
