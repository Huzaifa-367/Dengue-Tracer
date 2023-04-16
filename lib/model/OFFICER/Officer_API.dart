import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Officer/officer_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

AddOfficer(User u, context) async {
  FormData data = FormData.fromMap(u.tomap());
  var response = await Dio().post('$ip/CreateOfficerAndAssignSector',
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
