// import 'package:dengue_project/Widgets/button_widget.dart';
// import 'package:dengue_project/Widgets/textField_widget.dart';
// import 'package:dengue_project/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PreferencesScreen extends StatefulWidget {
//   @override
//   _PreferencesScreenState createState() => _PreferencesScreenState();
// }

// class _PreferencesScreenState extends State<PreferencesScreen> {
//  //bool _isDarkModeEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadDarkModeSetting();
//   }

//   void _loadDarkModeSetting() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isDarkModeEnabled = prefs.getString(name) ?? false;
//     });
//   }
// //store name and contact from inputtextfields in shared preferences in flutter?
//   void _saveDarkModeSetting(bool value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('dark_mode', value);
//   }

//   TextEditingController name = TextEditingController();
//   TextEditingController contact = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Preferences'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             InputTxtField(
//                 label: "Name",
//                 hintText: "Enter Your Name",
//                 controller: name,
//                 validator: null),
//             const SizedBox(
//               height: 20,
//             ),
//             InputTxtField(
//               label: "Contact",
//               hintText: "Enter Your Contact",
//               controller: contact,
//               validator: null,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const Divider(
//               color: Color.fromARGB(255, 253, 106, 96),
//               thickness: 2,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ButtonWidget(
//               btnText: "Save",
//               onPress: (() {
//                 setState(() {
//                   setState(() {
//                     _isDarkModeEnabled = !_isDarkModeEnabled;
//                   });
//                   _saveDarkModeSetting(_isDarkModeEnabled);
//                 });
//               }),
//             ),

//             const SizedBox(
//               height: 10,
//             ),
//             //ListView.builder(itemBuilder: ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//         // child: Column(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     Text('Dark Mode'),
//         //     Switch(
//         //       value: _isDarkModeEnabled,
//         //       onChanged: (value) {
//         //         setState(() {
//         //           _isDarkModeEnabled = value;
//         //         });
//         //         _saveDarkModeSetting(value);
//         //       },
//         //     ),
//         //   ],
//         // ),
//       ),
//     );
//   }
// }
