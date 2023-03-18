import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Officer/officer_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

AddOfficer(User u, context) async {
  FormData data = FormData.fromMap(u.tomap());
  var response = await Dio().post('$ip/NewOfficer',
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
      }));
  if (response.statusCode == 200) {
    if (response.data == "Exsist") {
      snackBar(context, "Account already exsists.");
    } else {
      snackBar(context, "New Officer account is created successfully.");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const OfficersListScreen();
        },
      ));
    }
  }
}
