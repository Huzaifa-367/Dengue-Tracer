import 'package:awesome_place_search/awesome_place_search.dart';
import 'package:dengue_tracing_application/model/MAP/Temp_Map_Api.dart';
//

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:dengue_tracing_application/model/USER/usermodel.dart';

import '../model/NOTIFICATION/notifmodel.dart';

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

TextEditingController ipcontroller = TextEditingController();
//GLOBAL
//Xperia 5 II

String ip = "192.168.183.34";
//
//Ahsan Mobile
//const String ip = "192.168.184.34";
// PTCL-5G
//const String ip = "192.168.10.12";
//
String api = 'http://$ip/FYP_Api/API/SERVER';
String imgpath = 'http://$ip//FYP_Api/Images/';
User? loggedInUser;
var apiresponse;
//Login
bool? isRemember = false;
//
//Login
String? savedEmail;
String? savedPassword;
bool? isfingerprint = false;
bool? isfinger;
//
//
//MAP
double? percentage = 0.0;
//User? loggedInUsercopy;
String mapapikey = "AIzaSyCvhbfvGx_1tXHprSZ4RTUfxySdtM9u0uo";
//
// place search
PredictionModel? prediction;
//Temporal MAP
List<ActionLists>? Actionitems = [];
//Profile
double currentSliderValue = 1.0;
//RESET
String? otp;
int? range;

//STATS
DateTime? FromDate;
DateTime? ToDate;

//
//
//Notifications
List<ItemLists>? locnotifitems = [];
List<ItemLists>? notifitems = [];
// List<dynamic>? locationBased;
// List<dynamic>? sectorBased;
int? locationBasedCount;
int? sectorBasedCount;
int? totalnotif;

///
///
///
/////
///Officer Verify Map
///
//var secId = 0;

//Maps
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

class Constants {
  // Name
  static String appName = "Rhinestone";

  // Material Design Color
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color lightAccent = const Color(0xFF3B72FF);
  static Color lightBackground = const Color(0xfffcfcff);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = const Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = const Color(0xff707070);
  static Color textPrimary = const Color(0xFF486581);
  static Color textDark = const Color(0xFF102A43);

  static Color backgroundColor = const Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = const Color(0xFF3ABD6F);
  static Color lightGreen = const Color(0xFFA1ECBF);

  // Yellow
  static Color darkYellow = const Color(0xFF3ABD6F);
  static Color lightYellow = const Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = const Color(0xFF3B72FF);
  static Color lightBlue = const Color(0xFF3EC6FF);

  // Orange
  static Color darkOrange = const Color(0xFFFFB74D);

  static double headerHeight = 228.5;
  static double paddingSide = 30.0;
}
