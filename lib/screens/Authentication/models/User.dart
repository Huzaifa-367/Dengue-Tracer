import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/screens/Authentication/Login.dart';
import 'package:dengue_tracing_application/screens/Authentication/models/usermodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../Global/constant.dart';
import '../../Home/dashboard.dart';
import '../Otp_Screen.dart';

login(email, password, context) async {
  var response = await Dio().get(
    '$ip/Login?email=$email&password=$password',
  );

  if (response.statusCode == 200) {
    //log(response.data);
    if (response.data != 'false') {
      loggedInUser = User.fromMap(response.data);
      //loggedInUsercopy = loggedInUser;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DashBoard(),
        ),
      );
    } else {
      snackBar(context, response.data);
    }
  } else {
    return null;
  }
}

signUp(User u, context) async {
  FormData data = FormData.fromMap(u.tomap());
  var response = await Dio().post('$ip/NewUser',
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
      }));
  if (response.statusCode == 200) {
    if (response.data == "Exsist") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data)));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ));
    }
  }
}

reset(email, context) async {
  var response = await Dio().get(
    '$ip/ResetPassword?email=$email',
  );
  if (response.statusCode == 200) {
    //log(response.data);

    otp = response.data;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Otp_Screen(
          email: email,
        ),
      ),
    );
  } else {
    return null;
  }
}

newpassword(User u, context) async {
  //FormData data = FormData.fromMap(ur.tomap());
  var response = await Dio()
      .get('$ip/UpdatePassword?email=${u.email}&newpassword=${u.password}');
  if (response.statusCode == 200) {
    snackBar(
      context,
      "Your Password Has Been Updated!",
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
  } else {
    return null;
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return const LoginScreen();
    //     },
    //   ),
    // );
  }
}
