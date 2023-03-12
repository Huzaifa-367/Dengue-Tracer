import 'dart:async';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/screens/Home/dashboard.dart';
import 'package:dengue_tracing_application/testings/Permissions.dart';
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);

    controller?.forward();

    Timer(
      const Duration(seconds: 5),
      isRemember != false && loggedInUser != null
          ? () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const DashBoard(),
                ),
              )
          : () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const PermissionHandlerScreen(),
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 20, 28, 1),
      body: SizedBox(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.8,
                child: Image.asset("assets/Dengue_Anim.gif"),
              ),
            ),
            TextAnimator(
              //'Welcome To Dengue Tracing Application',
              "Welcome",
              style: const TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(
                  curve: Curves.linearToEaseOut,
                  duration: const Duration(milliseconds: 1500)),
              atRestEffect: WidgetRestingEffects.dangle(),
              outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
            ),
            // const Text(
            //   "Welcome To Dengue Tracing Application",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 35,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
