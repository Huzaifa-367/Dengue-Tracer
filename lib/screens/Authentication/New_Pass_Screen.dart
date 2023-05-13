import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/model/USER/User_API.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';

import 'package:flutter/material.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  //const ForgotPassword({super.key});
  final String? email;
  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

bool? isSame;

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passcontr = TextEditingController();
  TextEditingController passcontr2 = TextEditingController();

  bool isVisible = true;

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/dengu.png"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Dengue Tracing Application",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: btnColor,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Enter Your New Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: grayshade,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: passcontr,
                    hintText: "Password",
                    obscureText: isVisible,

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
                    height: 20,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: passcontr2,
                    hintText: "Repeat Password",
                    obscureText: isVisible,

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
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: 3000,
                      child: ButtonWidget(
                        btnText: "Save",
                        onPress: () async {
                          if (passcontr.text == passcontr2.text) {
                            User u = User();
                            u.email = "${widget.email}";
                            u.password = passcontr.text;
                            newpassword(u, context);
                          } else {
                            snackBar(
                                context, "Please fill all fields correctly");
                          }

                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const LoginScreen(),
                          //   ),
                          // );
                        },
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
                        "Back To Login?",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
