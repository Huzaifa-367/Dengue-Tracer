import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Paths.dart';
import 'package:flutter/material.dart';

import '../../model/USER/User_API.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  //const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailcontr = TextEditingController();
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Forgot Your Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: grayshade,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "We Got Your Back",
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
                    controller: emailcontr,
                    hintText: "Email",
                    keytype: TextInputType.emailAddress,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
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
                        btnText: "Reset",
                        onPress: (() async {
                          // //const email = 'example@example.com';
                          // var url = Uri.parse(
                          //   '$ip/ResetPassword?email=${emailcontr.text}',
                          // );
                          // http.Response response = await http.get(url);

                          // if (response.statusCode == 200) {
                          //   final otp = response.body;
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //         content:
                          //             Text('OTP sent to ${emailcontr.text}')),
                          //   );
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Failed to send OTP')),
                          //   );
                          // }
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => const OTP_SCREEN(),
                          //   ),
                          // );
                          // myauth.setConfig(userEmail: emailcontr.text);
                          // if (myauth.sendOTP() == true) {
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(const SnackBar(
                          //     content: Text("OTP has been sent"),
                          //   ));
                          // } else {
                          //   ScaffoldMessenger.of(context)
                          //       .showSnackBar(const SnackBar(
                          //     content: Text("Oops, OTP send failed"),
                          //   ));
                          // }
                          reset(emailcontr.text, context);
                        }),
                      ),
                    ),
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
