import 'package:dengue_tracing_application/Global/Widgets/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Officer/officer_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

AddOfficer(User u, context) async {
  FormData data = FormData.fromMap(u.tomap());
  var response = await Dio().post('$api/CreateOfficerAndAssignSector',
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
      }));
  if (response.statusCode == 200) {
    if (response.data == "Officer already exists") {
      snackBar(context, "Account already exsists.");
    } else {
      snackBar(context, "Officer account created and sector assigned.");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const OfficersListScreen();
        },
      ));
    }
  }
}

UpdateOfficerSector(
    int? selectedSectorId, int? selectedofficerId, context) async {
  //FormData data = FormData.fromMap(u.tomap());
  var response = await Dio().post(
      '$api/AssignOfficerSectors?sec_id=$selectedSectorId&user_id=$selectedofficerId');
  // data: data,
  // options: Options(headers: {
  //   "Content-Type": "application/json",
  // }));
  if (response.statusCode == 200) {
    if (response.data == "Assigned") {
      snackBar(context, "Sector Assigned Successfully.");
    } else {
      snackBar(context, "Sector Updated Successfully.");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const OfficersListScreen();
        },
      ));
    }
  }
}

TakeAction(int? secId, context) async {
  var response = await Dio().post('$api/TakeAction?sec_id=$secId');
  if (response.statusCode == 200) {
    if (response.data == "Created") {
      snackBar(context, "Action Taken Successfully.");
      Navigator.of(context).pop();
    }
  }
}
