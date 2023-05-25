import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Widgets/Button_Widget_Api.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/Testing_Screen.dart';
import 'package:dengue_tracing_application/model/NOTIFICATION/Notif_Api.dart';
import 'package:dengue_tracing_application/model/USER/User_API.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/USER/usermodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  //const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  //TextEditingController text = TextEditingController();
  bool? isVisible = true;
//Shared Preference start

  //bool isRemember = false;

  @override
  void initState() {
    super.initState();
    loadUserEmailPassword();
  }

  //bool? isRemember;
//handle remember me function
  void handleRemeberme(bool value) {
    isRemember = value;
    if (isRemember == true) {
      SharedPreferences.getInstance().then(
        (prefs) {
          prefs.setBool("remember_me", value);
          prefs.setString('email', emailcont.text);
          prefs.setString('password', passwordcont.text);
        },
      );
      setState(() {
        isRemember = value;
      });
    }
  }

//load email and password
  void loadUserEmailPassword() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      savedEmail = prefs.getString("email") ?? "";
      savedPassword = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      if (remeberMe && savedEmail != "") {
        setState(
          () {
            isRemember = true;
          },
        );
        // emailcont = savedEmail as TextEditingController;
        // passwordcont = savedPassword as TextEditingController;
      }
    } catch (e) {
      print(e);
    }
  }

  //Shared Preference End

  bool isLoading = false;

  Future<void> login(String email, String password, bool isRemember,
      BuildContext context) async {
    // Your login logic here
    try {
      if (isRemember == true) {
        bool authenticated = await authenticateWithFingerprint();
        if (authenticated) {
          var response = await Dio().get(
            '$api/Login?email=$email&password=$password',
          );

          if (response.statusCode == 200) {
            //log(response.data);
            if (response.data != 'false') {
              // Save the email and password to shared preferences
              final List<dynamic> dataList = response.data;
              // Parse the first item in the list as a Map
              final Map<String, dynamic> dataMap = dataList.first;
              // Create a new User object from the map
              loggedInUser = User.fromMap(dataMap);
              // Navigate to dashboard screen with loggedInUser data
              _proceedToDashboard(context);
              fetchNotifications(loggedInUser!.user_id, 0);
            } else {
              snackBar(context, "Incorrect Email or Password.");
            }
          } else {
            snackBar(context, "Failed to connect to the server.");
          }
        } else {
          snackBar(context, "Fingerprint Authentication is not saved.");
        }
      } else {
        var response = await Dio().get(
          '$api/Login?email=$email&password=$password',
        );

        if (response.statusCode == 200) {
          //log(response.data);
          if (response.data != 'false') {
            // Save the email and password to shared preferences
            final List<dynamic> dataList = response.data;
            // Parse the first item in the list as a Map
            final Map<String, dynamic> dataMap = dataList.first;
            // Create a new User object from the map
            loggedInUser = User.fromMap(dataMap);
            // Navigate to dashboard screen with loggedInUser data
            _proceedToDashboard(context);
          } else {
            snackBar(context, "Incorrect Email or Password.");
          }
        } else {
          snackBar(context, "Failed to connect to the server.");
        }
      }
    } catch (e) {
      snackBar(context, "An error occurred: ");
    }
    // This is just a placeholder
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // Navigate to the next screen or show a snackbar
  }

  void _proceedToDashboard(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DashBoard(),
      ),
    );
  }

  Future<void> loginWithLoadingAnimation() async {
    setState(() {
      isLoading = true;
    });

    // Call the login function or API
    await login(emailcont.text, passwordcont.text, isRemember!, context);

    setState(() {
      isLoading = false;
    });
  }

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
                    "Dengue Tracing",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: btnColor,
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    "Application",
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
                    "Sign In",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: txtColor,
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Hi there! Nice to see you again.",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      color: grayshade,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: emailcont,
                    hintText: "Email",
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    maxlines: 1,
                    //siconn: Icons.email,
                    controller: passwordcont,
                    hintText: "Password",
                    obscureText: isVisible,

                    prefixIcon: const Icon(Icons.password),
                    sufixIconPress: () {
                      setState(() {
                        isVisible = !isVisible!;
                      });
                    },
                    sufixIcon:
                        isVisible! ? Icons.visibility : Icons.visibility_off,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Switch.adaptive(
                          thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                              (Set<MaterialState> states) {
                            return isRemember == true
                                ? const Icon(
                                    Icons.check_circle_outline_rounded,
                                    size: 25,
                                  )
                                : const Icon(
                                    Icons.close_rounded,
                                    size: 25,
                                  );
                          }),
                          inactiveTrackColor:
                              const Color.fromARGB(255, 255, 255, 255),
                          inactiveThumbColor:
                              const Color.fromARGB(255, 246, 195, 195),
                          //enableFeedback: true,

                          activeColor: btnColor,
                          value: isRemember!,
                          onChanged: (value) {
                            setState(
                              () {
                                isRemember = !value;
                                handleRemeberme(value);
                              },
                            );
                          },
                        ),
                        const Text(
                          "Remember me",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 226, 99, 99),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: (() {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassword(),
                              ),
                            );
                          }),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 226, 99, 99),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 250,
                          // child: ButtonWidget(

                          //   btnText: "Login",
                          //   onPress: (() async {
                          //     emailcont.text != ""
                          //         ? await login(
                          //             emailcont.text,
                          //             passwordcont.text,
                          //             isRemember,
                          //             context,
                          //           )
                          //         : snackBar(context,
                          //             "Please enter email & password!");
                          //     // User u = User();
                          //     // u.email = emailcont.text;
                          //     // u.password = passwordcont.text;
                          //     // String? response = await u.login();
                          //     // if (response == null) {
                          //     //   //show alert of error
                          //     // } else if (response == "\"false\"") {
                          //     //   //show alert invalued email password
                          //     // } else {
                          //     //   dynamic map = jsonDecode(response);
                          //     //   //String role = map["role"].toLowerCase();
                          //     //   String email = map["email"];
                          //     //   String password = map['password'];

                          //     //   User u = User.fromMap(map);
                          //     //setState(() {});

                          //     // }
                          //   }),
                          // ),

                          child: ButtonApiWidget(
                            btnText: "Login",
                            onPress: loginWithLoadingAnimation,
                            isloading: isLoading,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            isRemember == true && savedEmail != ""
                                ? await login(
                                    savedEmail!,
                                    savedPassword!,
                                    isRemember!,
                                    context,
                                  )
                                : snackBar(
                                    context, "Remember Me is not active.");
                          },
                          icon: const Icon(
                            Icons.fingerprint_rounded,
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't Have An Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                      TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        }),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 226, 99, 99),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Testings_Screen(),
                        ),
                      );
                    }),
                    child: RoundIcon(
                      icon: Icons.settings,
                      backgroundColor: bkColor,
                      iconColor: btnColor,
                      size: 35,
                    ),
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
