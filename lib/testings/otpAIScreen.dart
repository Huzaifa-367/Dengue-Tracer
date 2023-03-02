import 'dart:async';

import 'package:dengue_tracing_application/screens/Authentication/New_Pass_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:dengue_tracing_application/Global/constant.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    Key? key,
    this.email,
  }) : super(key: key);

  final String? email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpcontroller = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: btnColor,
        content: Text(
          message!,
          style: GoogleFonts.gemunuLibre(
            fontWeight: FontWeight.w800,
            color: ScfColor,
            fontSize: 15,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          body: GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 30),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(Images.otpGifImage),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Email Verification',
                      style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 8),
                    child: RichText(
                      text: TextSpan(
                        text: "Enter the code sent to :  ",
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          color: grayshade,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: "${widget.email}",
                            style: GoogleFonts.gemunuLibre(
                              color: tbtnColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                        // style: const TextStyle(
                        //   color: Colors.black54,
                        //   fontSize: 15,
                        // ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 40,
                      ),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: btnColor,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        obscuringCharacter: '*',
                        // obscuringWidget: const FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 6) {
                            return "OTP Incomplete";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          activeColor: bkColor,
                          selectedColor: btnColor,
                          inactiveColor: bkColor,
                          inactiveFillColor: btnColor,
                          selectedFillColor: btnColor,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 45,
                          fieldWidth: 40,
                          activeFillColor:
                              const Color.fromARGB(255, 254, 249, 244),
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: otpcontroller,
                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          debugPrint("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: GoogleFonts.gemunuLibre(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          color: grayshade,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          snackBar("OTP resend!!");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    email: "${widget.email}",
                                  )));
                        }),
                        child: Text(
                          "Resend",
                          style: GoogleFonts.gemunuLibre(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 226, 99, 99),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 30),
                    decoration: BoxDecoration(
                        color: btnColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: bkColor,
                              offset: const Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: bkColor,
                              offset: const Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                          // conditions for validating
                          if (currentText.length != 6 ||
                              currentText != "123456") {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            setState(
                              () {
                                hasError = false;
                                snackBar("OTP Verified!!");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NewPasswordScreen(),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
                            style: GoogleFonts.gemunuLibre(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: TextButton(
                          child: const Text("Clear"),
                          onPressed: () {
                            otpcontroller.clear();
                          },
                        ),
                      ),
                      Flexible(
                        child: TextButton(
                          child: const Text("Set Text"),
                          onPressed: () {
                            setState(() {
                              otpcontroller.text = "123456";
                            });
                          },
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
