// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool? _isChecked = false;

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void initState() {
//     _loadUserEmailPassword();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blueAccent,
//           title: const Text("Login Page"),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(children: [
//               field(_emailController, const Icon(Icons.email_outlined),
//                   "Enter Email"),
//               const SizedBox(
//                 height: 10,
//               ),
//               field(_passwordController, const Icon(Icons.lock),
//                   "Enter password"),
//               const SizedBox(
//                 height: 10,
//               ),
//               GestureDetector(
//                   onTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LogoutPage()));
//                   },
//                   child: const Text("Login",
//                       style: TextStyle(color: Colors.blue))),
//               Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                 SizedBox(
//                     height: 24.0,
//                     width: 24.0,
//                     child: Theme(
//                       data: ThemeData(
//                           unselectedWidgetColor:
//                               const Color(0xff00C8E8) // Your color
//                           ),
//                       child: Checkbox(
//                         activeColor: const Color(0xff00C8E8),
//                         value: _isChecked,
//                         onChanged: _handleRemeberme,
//                       ),
//                     )),
//                 const SizedBox(width: 10.0),
//                 const Text("Remember Me",
//                     style: TextStyle(
//                         color: Color(0xff646464),
//                         fontSize: 12,
//                         fontFamily: 'Rubic'))
//               ])
//             ]),
//           ),
//         ));
//   }

//   field(TextEditingController controller, Icon icon, String label) {
//     return Container(
//       decoration: BoxDecoration(
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.white,
//               blurRadius: 5.0,
//             ),
//           ],
//           borderRadius: BorderRadius.circular(30),
//           border: Border.all(color: const Color(0xffECEBEB))),
//       child: TextField(
//           controller: controller,
//           //onChanged: onchange,

//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.only(top: 8, left: 20),
//             focusedBorder: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//             disabledBorder: InputBorder.none,
//             border: InputBorder.none,
//             suffixIcon: icon,
//             labelText: label,
//             labelStyle:
//                 const TextStyle(fontSize: 14, decoration: TextDecoration.none),
//           )),
//     );
//   }

//   void _handleRemeberme(bool value) {
//     print("Handle Rember Me");
//     _isChecked = value;
//     SharedPreferences.getInstance().then(
//       (prefs) {
//         prefs.setBool("remember_me", value);
//         prefs.setString('email', _emailController.text);
//         prefs.setString('password', _passwordController.text);
//       },
//     );
//     setState(() {
//       _isChecked = value;
//     });
//   }

//   void _loadUserEmailPassword() async {
//     print("Load Email");
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var email = prefs.getString("email") ?? "";
//       var password = prefs.getString("password") ?? "";
//       var remeberMe = prefs.getBool("remember_me") ?? false;

//       print(remeberMe);
//       print(email);
//       print(password);
//       if (remeberMe) {
//         setState(() {
//           _isChecked = true;
//         });
//         _emailController.text = email ?? "";
//         _passwordController.text = password ?? "";
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// class LogoutPage extends StatelessWidget {
//   const LogoutPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Logout"),
//         actions: [
//           GestureDetector(
//               onTap: () {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginPage()),
//                     (route) => false);
//               },
//               child: const Icon(Icons.logout))
//         ],
//       ),
//     );
//   }
// }
