library MYemail_otp;

import 'dart:convert';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:http/http.dart' as http;

//enum OTPType { digitsOnly, stringOnly, mixed }

class EmailOTP {
  /// Name of your application.
  //String? _appName;

  /// Your email address.
  //String? _appEmail;

  ///Email address of client, where you want to send OTP
  String? _userEmail;

  ///Will save correct OTP
  String? _getOTP;

  //Custom length for otp digits
  //int? _otpLength;

  //Custom OTP Type
  //String? _type;

  ///Function use to config Email OTP
  setConfig({
    // appName,
    // appEmail,
    userEmail,
    // otpLength,
    // otpType,
  }) {
    // _appName = appName;
    // _appEmail = appEmail;
    _userEmail = userEmail;
    // _otpLength = otpLength;
    // switch (otpType) {
    //   case OTPType.digitsOnly:
    //     _type = "digits";
    //     break;
    //   case OTPType.stringOnly:
    //     _type = "string";
    //     break;
    //   case OTPType.mixed:
    //     _type = "mixed";
    //     break;
    // }
  }

  ///Function will return true / false
  sendOTP() async {
    var url = Uri.parse(
      '$ip/ResetPassword?email=$_userEmail',
    );
    http.Response response = await http.get(url);
    try {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        if (decodedData['status'] == true) {
          _getOTP = decodedData['otp'].toString();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  ///Function will return true / false
  verifyOTP({otp}) {
    if (_getOTP == otp) {
      print("OTP has been verified! ✅");
      return true;
    } else {
      print("OTP is invalid ❌");
      return false;
    }
  }
}

























// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

// import 'package:dengue_tracing_application/Global/constant.dart';

// import 'package:http/http.dart' as http;

// class Reset {
//   String? email;
//   int? otp;
//   late int user_id;
//   Reset();
//   Reset.fromMap(Map<String, dynamic> map) {
//     //name = map['name'];
//     email = map["email"];
//     otp = map["otp"];
//     //role = map["role"];
//     //image = map["image"];
//     //user_id = map["user_id"];
//   }

//   Future<String?> resetpass() async {
//     String url = '$ip/ResetPassword?email=$email';
//     Uri uri = Uri.parse(url);
//     var response = await http.get(uri);
//     if (response.statusCode == 200) {
//       return response.body;
//     }

//     return null;
//   }

//   //Sign up

//   Map<String, dynamic> tomap() {
//     return <String, dynamic>{
//       'email': email,
//       'password': otp,
//     };
//   }

//   Future<String?> signupMutliPart() async {
//     String url = '$ip/NewUser';
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.fields['role'] = role;
//     request.fields['name'] = name;
//     request.fields['email'] = email;
//     request.fields['phone_number'] = phone_number;
//     request.fields['password'] = password;

//     request.fields['home_location'] = home_location;
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       return response.stream.bytesToString();
//     }
//     return null;
//   }

//   Future<String?> uploadPic(File f) async {
//     String url = '$ip/UpdateuserImage';
//     Uri uri = Uri.parse(url);
//     var request = http.MultipartRequest('POST', uri);
//     request.fields["id"] = user_id.toString();
//     http.MultipartFile newfile =
//         await http.MultipartFile.fromPath('photo', f.path);
//     request.files.add(newfile);
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       return 'Uploaded';
//     }

//     return null;
//   }
//}
