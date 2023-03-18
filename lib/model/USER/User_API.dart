import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/screens/Authentication/Login.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Global/constant.dart';
import '../../screens/Home/dashboard.dart';
import '../../screens/Authentication/Otp_Screen.dart';

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
      snackBar(context, "Incorrect Email or Password.");
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
      snackBar(context, "Account already exsists.");
    } else {
      snackBar(context, "Your account is created successfully.");
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

updateUserStatus(context, int userId, bool status) async {
  var response =
      await Dio().post('$ip/UpdateUserStatus?user_id=$userId&status=$status');
  // final String apiUrl = '$ip/UpdateUserStatus';
  // final response = await http.post(Uri.parse(apiUrl), body: {
  //   'user_id': userId.toString(),
  //   'status': status.toString(),
  // });

  if (response.statusCode == 200) {
    snackBar(
      context,
      "Your Status Has Been Updated!",
    );
    //return jsonDecode(response.body)['message'];
  } else {
    snackBar(
      context,
      "Failed!",
    );
    //throw Exception('Failed to update user status.');
  }
}

// Future<void> updateUserStatus(int userId, bool userStatus) async {
//   final response = await http.post(
//     Uri.parse('$ip/UpdateUserStatus'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'user_id': userId,
//       'status': userStatus,
//     }),
//   );
//   if (response.statusCode == 200) {
//     // print("User status updated successfully");
//   } else {
//     throw Exception('Failed to update user status');
//   }
// }