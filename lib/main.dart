import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/screens/Welcome/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DengueProject());

class DengueProject extends StatelessWidget {
  const DengueProject({Key? key}) : super(key: key);

  //const DengueProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: btnColor,
      ),
      debugShowCheckedModeBanner: false,

      home: const SplashScreen(),
      //home: const Expandable_Table_Screen(),
    );
  }
}
