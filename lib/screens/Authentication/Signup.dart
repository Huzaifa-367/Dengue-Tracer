// ignore_for_file: use_build_context_synchronously
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Paths.dart';
import 'package:dengue_tracing_application/model/USER/User_API.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:map_location_picker/map_location_picker.dart';

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
  bool isVisible2 = true;

  var textController = TextEditingController();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.643005, 73.077706),
    zoom: 14.4746,
  );

  String role = 'user';
  int? sec_id;
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
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
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
                    obscureText: isVisible2,
                    keytype: TextInputType.text,

                    prefixIcon: const Icon(Icons.password),
                    sufixIconPress: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    sufixIcon:
                        isVisible2 ? Icons.visibility : Icons.visibility_off,
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
                      var LocId = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PickLocation(),
                          //builder: (context) => const MapScreen(),
                        ),
                      );
                      setState(() {
                        final LocSecid = LocId.split('-');
                        home_loccont.text = LocSecid[0];
                        sec_id = LocSecid[1] == "You,re not in our Sectors."
                            ? null
                            : int.parse(LocSecid[1]);
                      });

                      //builder: (context) => const Mapp_test()));
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
                            u.sec_id = sec_id;
                            await signUp(
                              u,
                              context,
                            );
                          } else {
                            snackBar(
                                context, "Please fill all fields correctly");
                          }
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
