// import 'package:dengue_tracing_application/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DarkTheme extends StatefulWidget {
//   const DarkTheme({super.key});

//   @override
//   State<DarkTheme> createState() => _DarkThemeState();
// }

// class _DarkThemeState extends State<DarkTheme> {
//   @override
//   Widget build(BuildContext context) {
//    // final themeChanger = Provider.of<ThemeChangerProvider>(context);
//     print("Build");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Theme Changer"),
//       ),
//       body: Column(
//         children: [
//           RadioListTile<ThemeMode>(
//             title: const Text(
//               "Light Mode",
//               style: TextStyle(
//                 fontFamily: 'avenir',
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             value: ThemeMode.light,
//             groupValue: themeChanger.themeMode,
//             onChanged: themeChanger.setTheme,
//           ),
//           RadioListTile<ThemeMode>(
//             title: const Text(
//               "Dark Mode",
//               style: TextStyle(
//                 fontFamily: 'avenir',
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             value: ThemeMode.dark,
//             groupValue: themeChanger.themeMode,
//             onChanged: themeChanger.setTheme,
//           ),
//           RadioListTile<ThemeMode>(
//             title: const Text(
//               "System Mode",
//               style: TextStyle(
//                 fontFamily: 'avenir',
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             value: ThemeMode.system,
//             groupValue: themeChanger.themeMode,
//             onChanged: themeChanger.setTheme,
//           )
//         ],
//       ),
//     );
//   }
// }

// final darkTheme = ThemeData(
//   primarySwatch: Colors.grey,
//   primaryColor: Colors.black,
//   brightness: Brightness.dark,
//   //backgroundColor: const Color(0xFF212121),
//   colorScheme: ColorScheme(
//     primary: Colors.black,
//     secondary: Colors.yellow[700]!,
//     surface: const Color(0xFF212121),
//     background: const Color(0xFF212121),
//     onPrimary: Colors.yellow[700]!,
//     onSecondary: Colors.yellow[700]!,
//     onSurface: Colors.yellow[700]!,
//     onBackground: Colors.yellow[700]!,
//     onError: Colors.grey,
//     error: Colors.red,
//     brightness: Brightness.dark,
//   ),
//   dividerColor: Colors.black12,
// );

// final lightTheme = ThemeData(
//   primarySwatch: Colors.grey,
//   primaryColor: Colors.white,
//   brightness: Brightness.light,
//   //backgroundColor: const Color(0xFFE5E5E5),
//   appBarTheme:
//       const AppBarTheme(color: Colors.white, foregroundColor: Colors.black),
//   colorScheme: const ColorScheme(
//     primary: Colors.white,
//     secondary: Colors.black,
//     surface: Color(0xFFE5E5E5),
//     background: Color(0xFFE5E5E5),
//     onPrimary: Colors.black,
//     onSecondary: Colors.black,
//     onSurface: Colors.black,
//     onBackground: Colors.black,
//     onError: Colors.grey,
//     error: Colors.red,
//     brightness: Brightness.light,
//   ),
//   dividerColor: Colors.white54,
// );

// class ThemeNotifier with ChangeNotifier {
//   ThemeData _themeData;

//   ThemeNotifier(this._themeData);

//   getTheme() => _themeData;

//   setTheme(ThemeData themeData) async {
//     _themeData = themeData;
//     notifyListeners();
//   }
// }
