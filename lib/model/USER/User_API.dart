import 'package:dengue_tracing_application/Global/Widgets/SnackBar_widget.dart';
import 'package:dengue_tracing_application/screens/Authentication/Login.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Global/constant.dart';
import '../../screens/Home/dashboard.dart';
import '../../screens/Authentication/Otp_Screen.dart';

login(email, password, context) async {
  var response = await Dio().get(
    '$api/Login?email=$email&password=$password',
  );

  if (response.statusCode == 200) {
    //log(response.data);
    if (response.data != 'false') {
      final List<dynamic> dataList = response.data;

      // Parse the first item in the list as a Map
      final Map<String, dynamic> dataMap = dataList.first;

      // Create a new User object from the map
      loggedInUser = User.fromMap(dataMap);

      // Navigate to dashboard screen with loggedInUser data
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
  var response = await Dio().post(
    '$api/SignUp',
    data: data,
    options: Options(
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );
  if (response.statusCode == 200) {
    if (response.data == "Exsist") {
      snackBar(context, "Account already exsists.");
    } else {
      snackBar(context, "Your account is created successfully.");
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) {
      //     return const LoginScreen();
      //   },
      // ));
    }
  }
}

// Future<void> signUp(User u, context) async {
//   final Map<String, dynamic> userData = u.tomap();
//   try {
//     final response = await Dio().post('$api/NewUser', data: userData);
//     if (response.statusCode == 200) {
//       final String message = response.data;
//       if (message == 'Created') {
//         // Navigate to login screen after successful signup
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) {
//               return const LoginScreen();
//             },
//           ),
//         );
//         snackBar(context, 'Account created successfully. Please login.');
//       } else if (message == 'Exist') {
//         snackBar(context, 'An account with this email already exists.');
//       } else {
//         snackBar(context, 'Error creating account. Please try again later.');
//       }
//     } else {
//       snackBar(context, 'Error creating account. Please try again later.');
//     }
//   } catch (error) {
//     snackBar(context, 'Error creating account. Please try again later.');
//   }
// }

reset(email, context) async {
  var response = await Dio().get(
    '$api/ResetPassword?email=$email',
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
      .get('$api/UpdatePassword?email=${u.email}&newpassword=${u.password}');
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
      await Dio().post('$api/UpdateUserStatus?user_id=$userId&status=$status');
  // final String apiUrl = '$api/UpdateUserStatus';
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
//     Uri.parse('$api/UpdateUserStatus'),
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
