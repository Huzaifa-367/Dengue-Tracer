// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';
import 'package:dengue_tracing_application/Global/constant.dart';

import 'package:http/http.dart' as http;

class OfficerSectors {
  int? sec_id;
  String? sec_name, sec_description;

  //officer
  OfficerSectors();
  OfficerSectors.fromMap(Map<String, dynamic> map) {
    sec_id = map['sec_id'];
    sec_name = map['sec_name'];
    sec_description = map['description'];
  }

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      'sec_id': sec_id,

      // "sec_name": sec_name,
      // "description": sec_description,
    };
  }
}

//
//
//
class User {
  String? name, phone_number, email, password, role, home_location;
  //,office_location;
  String? image;
  String? office_location, sec_name, sec_description;
  DateTime? startDate;
  bool? status;
  DateTime? endDate;
  int? sec_id;
  late int user_id;
  //officer
  var sectors;
  User();
  User.fromMap(Map<String, dynamic> map) {
    sec_id = map['sec_id'];
    name = map['name'];
    email = map["email"];
    password = map["password"];
    role = map["role"];
    image = map["image"];
    user_id = map["user_id"];
    home_location = map["home_location"];
    office_location = map["office_location"];
    phone_number = map["phone_number"];
    sec_name = map['sec_name'];
    sec_description = map['description'];
    //User
    startDate =
        map['startdate'] != null ? DateTime.parse(map['startdate']) : null;
    status = map['status'];
    endDate = map['enddate'] != null ? DateTime.parse(map['enddate']) : null;

    // if (role == "officer") {
    //   //officer
    //   //Needs Working
    //   List<OfficerSectors> sectorsList = [];
    //   if (map['sectors'] != null) {
    //     var sectorsData = map['sectors'];
    //     if (sectorsData is List) {
    //       for (var sectorData in sectorsData) {
    //         sectorsList.add(OfficerSectors.fromMap(sectorData));
    //       }
    //     }
    //   }
    //   sectors = sectorsList;
    // }
  }

  // Future<String?> login() async {
  //   String url = '$api/Login?email=$email&password=$password';
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
      'sec_id': sec_id,
      'role': role,
      'name': name,
      'email': email,
      'phone_number': phone_number,
      'password': password,
      'home_location': home_location,
      // "office_location": office_location,
      // "sec_name": sec_name,
      // "description": sec_description,
      // "startdate": startdate,
      // "status": status,
      // "enddate": enddate,
    };
  }

  // Future<String?> signupMutliPart() async {
  //   String url = '$api/NewUser';
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
    String url = '$api/UpdateuserImage';
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

///
///
///
///
class Officer {
  int userId;
  String name;
  String email;
  String phoneNumber;
  String role;
  List<String> sectors;

  Officer({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.sectors,
  });
}

class Sector {
  int secId;
  String secName;
  int threshold;
  String description;
  List<String> latLongs;
  int totalCases;

  Sector({
    required this.secId,
    required this.secName,
    required this.threshold,
    required this.description,
    required this.latLongs,
    required this.totalCases,
  });
}
