// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'package:dengue_tracing_application/Global/constant.dart';

import 'package:http/http.dart' as http;

class User {
  String? name, phone_number, email, password, role, home_location;
  //,office_location;
  String? image;
  late int user_id;
  User();
  User.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map["email"];
    password = map["password"];
    role = map["role"];
    image = map["image"];
    user_id = map["user_id"];
    home_location = map["home_location"];
    phone_number = map["phone_number"];
  }

  // Future<String?> login() async {
  //   String url = '$ip/Login?email=$email&password=$password';
  //   Uri uri = Uri.parse(url);
  //   var response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }

  //   return null;
  // }

  //Sign up

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'role': role,
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'password': password,
      'home_location': home_location,
    };
  }

  // Future<String?> signupMutliPart() async {
  //   String url = '$ip/NewUser';
  //   var request = http.MultipartRequest('POST', Uri.parse(url));
  //   request.fields['role'] = role;
  //   request.fields['name'] = name;
  //   request.fields['email'] = email;
  //   request.fields['phone_number'] = phone_number;
  //   request.fields['password'] = password;

  //   request.fields['home_location'] = home_location;
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     return response.stream.bytesToString();
  //   }
  //   return null;
  // }

  Future<String?> uploadPic(File f) async {
    String url = '$ip/UpdateuserImage';
    Uri uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);
    request.fields["user_id"] = user_id.toString();
    http.MultipartFile newfile =
        await http.MultipartFile.fromPath('image', f.path);
    //loggedInUser!.image = newfile.toString();
    request.files.add(newfile);
    var response = await request.send();
    if (response.statusCode == 200) {
      //loggedInUser!.image = ;
      return 'Uploaded';
    }

    return null;
  }
}

// class UserReset {
//   late String email, newpassword;

//   UserReset();
//   UserReset.fromMap(Map<String, dynamic> map) {
//     email = map["email"];
//     newpassword = map["password"];
//   }
//   Map<String, dynamic> tomap() {
//     return <String, dynamic>{
//       'email': email,
//       'password': newpassword,
//     };
//   }
// }
