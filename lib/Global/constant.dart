import 'package:dengue_tracing_application/screens/Authentication/models/usermodel.dart';
import 'package:flutter/material.dart';

Color btnColor = const Color(0XFFf85f6a);
Color bkColor = const Color.fromARGB(255, 247, 214, 216);
Color txtColor = const Color.fromARGB(255, 0, 0, 0);
Color ScfColor = const Color.fromARGB(255, 255, 249, 249);
Color tbtnColor = const Color.fromARGB(255, 245, 130, 130);
Color greenColor = Colors.green.shade200;

String ip = 'http://192.168.9.7/FYP_Api/API/SERVER';
String imgpath = 'http://192.168.9.7/FYP_Api/Images/';
User? loggedInUser;
//User? loggedInUsercopy;
String mapapikey = "AIzaSyDdb1AI9QsduWLWJs-Dx4_MaPL3VO4XPdw";
String? otp;
int? range;
// class Constants {
//   static const Color primaryColor = Color(0xffFBFBFB);
//   static const String otpGifImage = "assets/otp.gif";

// }
class Images {
  static const String otpGifImage = "assets/otp.gif";
  static const String dpImage = "assets/avatar-3.png";
}

Color lightgreenshede = const Color(0xFFF0FAF6);
Color lightgreenshede1 = const Color(0xFFB2D9CC);
Color greenshede0 = const Color(0xFF66A690);
Color greenshede1 = const Color(0xFF93C9B5);
Color primarygreen = const Color(0xFF1E3A34);
Color grayshade = const Color(0xFF93B3AA);
Color colorAcent = const Color(0xFF78C2A7);
Color cyanColor = const Color(0xFF6D7E6E);

const kAnimationDuration = Duration(milliseconds: 200);

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;
