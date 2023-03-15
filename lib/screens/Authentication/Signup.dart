// ignore_for_file: use_build_context_synchronously

import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/textfield_Round_readonly.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:dengue_tracing_application/screens/Authentication/Location_Picker.dart';
import 'package:dengue_tracing_application/screens/Authentication/models/User.dart';
import 'package:dengue_tracing_application/screens/Authentication/models/usermodel.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:map_location_picker/map_location_picker.dart';

import 'Login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  //const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // PickResult? selectedPlace;
  // final LatLng kInitialPosition = const LatLng(33.643272, 73.079070);
  bool isVisible = true;

  var textController = TextEditingController();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 14.4746,
  );

  String role = 'user';
  String? response;
  TextEditingController namecont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  TextEditingController passwordcont2 = TextEditingController();
  TextEditingController home_loccont = TextEditingController();
  // TextEditingController office_loccont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: Colors.amber,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/dengu.png"),
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: txtColor,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: namecont,
                    hintText: "Name",
                    keytype: TextInputType.text,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.person),
                    //sufixIcon: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: emailcont,
                    hintText: "Email",
                    keytype: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
                    //sufixIcon: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    controller: phonecont,
                    hintText: "Phone Number",
                    keytype: TextInputType.phone,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.call),
                    // sufixIcon: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: passwordcont,
                    hintText: "Password",
                    obscureText: isVisible,
                    keytype: TextInputType.text,

                    prefixIcon: const Icon(Icons.password),
                    sufixIconPress: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    sufixIcon:
                        isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: passwordcont2,
                    hintText: "Repeat Password",
                    obscureText: isVisible,
                    keytype: TextInputType.text,

                    prefixIcon: const Icon(Icons.password),
                    sufixIconPress: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    sufixIcon:
                        isVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField_ReadOnly(
                    maxlines: 2,
                    readonly: true,
                    controller: home_loccont,
                    hintText: "Home Location",

                    sufixIconPress: () async {
                      home_loccont.text = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const PickLocation()));
                      // textController.text =
                      //     "${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}";
                      // Navigator.of(context).pop();
                    },
                    //prefixIcon: const Icon(Icons.map),
                    sufixIcon: Icons.arrow_forward_rounded,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ButtonWidget(
                        btnText: "Sign Up",
                        onPress: (() async {
                          if (passwordcont.text == passwordcont2.text &&
                              namecont.text != "" &&
                              emailcont.text != "") {
                            User u = User();
                            u.role = role;
                            u.name = namecont.text;
                            u.email = emailcont.text;
                            u.phone_number = phonecont.text;
                            u.password = passwordcont.text;
                            u.home_location = home_loccont.text;
                            await signUp(u, context);
                          } else {
                            snackBar(
                                context, "Please fill all fields correctly");
                          }

                          // response = await u.signupMutliPart();
                          // if (response == null) {
                          //   response = 'Error..';
                          // } else if (response == "\"Exsist\"") {
                          //   response = 'Account already exsist';
                          // } else {
                          //   response = 'Account created';
                          // }
                          // setState(() {});
                          //snackBar(context, "$response");
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const LoginScreen(),
                          //   ),
                          // );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already Have An Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        }),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 226, 99, 99),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
