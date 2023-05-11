import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Color tnColor = const Color.fromARGB(255, 255, 0, 17);
Color btnColor = const Color(0XFFf85f6a);
Color bkColor = const Color.fromARGB(255, 247, 214, 216);
Color txtColor = const Color.fromARGB(255, 0, 0, 0);
Color ScfColor = const Color(0xF5F5F5F5);
Color ScfColor2 = const Color.fromARGB(255, 255, 249, 249);
Color ScfColor3 = const Color(0xfff2f9fe);
const Color grey = Colors.grey;

Color tbtnColor = const Color.fromARGB(255, 245, 130, 130);
Color greenColor = Colors.green.shade200;

const Color primary = Color(0xfff2f9fe);
const Color secondary = Color(0xFFdbe4f3);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color red = Color(0xFFec5766);
const Color green = Color(0xFF43aa8b);
const Color blue = Color(0xFF28c2ff);
const Color buttoncolor = Color(0xff3e4784);
const Color mainFontColor = Color(0xff565c95);
const Color arrowbgColor = Color(0xffe4e9f7);

Color redopc = const Color.fromARGB(255, 216, 74, 74).withOpacity(0.3);
Color orangeopc = const Color.fromARGB(162, 253, 148, 42).withOpacity(0.3);
Color yellowopc = const Color.fromARGB(255, 216, 202, 74).withOpacity(0.3);
Color greenopc = const Color.fromARGB(255, 74, 216, 192).withOpacity(0.3);

Color redopcN = const Color.fromARGB(255, 216, 74, 74);
Color orangeopcN = const Color.fromARGB(162, 253, 148, 42);
Color yellowopcN = const Color.fromARGB(255, 216, 202, 74);
Color greenopcN = const Color.fromARGB(255, 74, 216, 192);

//GLOBAL
String ip = 'http://192.168.133.34/FYP_Api/API/SERVER';
String imgpath = 'http://192.168.133.34/FYP_Api/Images/';
User? loggedInUser;
bool? isRemember = false;

//MAP
double? percentage = 0.0;
//User? loggedInUsercopy;
String mapapikey = "AIzaSyDdb1AI9QsduWLWJs-Dx4_MaPL3VO4XPdw";

//RESET
String? otp;
int? range;

//STATS
DateTime? FromDate;
DateTime? ToDate;

List<Marker> markers = [];
// class Constants {
//   static const Color primaryColor = Color(0xffFBFBFB);
//   static const String otpGifImage = "assets/otp.gif";
List<Map<String, double>>? points;

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
