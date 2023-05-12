// //Shared Preference start

//   //bool isRemember = false;

//   import 'package:shared_preferences/shared_preferences.dart';

// @override
//   void initState() {
//     _loadUserEmailPassword();
//     super.initState();
//   }

//   void _handleRemeberme(bool value) {
//     //print("Handle Rember Me");
//     isRemember = value;
//     SharedPreferences.getInstance().then(
//       (prefs) {
//         prefs.setBool("remember_me", value);
//         prefs.setString('email', emailcont.text);
//         prefs.setString('password', passwordcont.text);
//       },
//     );
//     setState(() {
//       isRemember = value;
//     });
//   }

//   void _loadUserEmailPassword() async {
//     //print("Load Email");
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var email = prefs.getString("email") ?? "";
//       var password = prefs.getString("password") ?? "";
//       var remeberMe = prefs.getBool("remember_me") ?? false;

//       // print(remeberMe);
//       // print(email);
//       // print(password);
//       if (remeberMe) {
//         setState(() {
//           isRemember = true;
//         });
        
//         emailcont.text = email ?? "";
//         passwordcont.text = password ?? "";
//         await login(emailcont.text, passwordcont.text, context);
//       }
//     } catch (e) {
//       //print(e);
//     }
//   }