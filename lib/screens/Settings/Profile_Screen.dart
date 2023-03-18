import 'package:app_feedback/app_feedback.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
//import 'package:dengue_tracing_application/Global/BigUserCard.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/rangeslider.dart';
import 'package:dengue_tracing_application/Global/tester.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/model/USER/User_API.dart';
import 'package:dengue_tracing_application/screens/Authentication/Login.dart';
import 'package:dengue_tracing_application/screens/Settings/AboutUs_Screen.dart';
import 'package:dengue_tracing_application/screens/Settings/profileEdit_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'Admin_Officer/Officer/officer_view.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({super.key});

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  //
  //FeedBack Code Starts
  AppFeedback feedbackForm = AppFeedback.instance;

  UserFeedback? feedback;

  void launchAppFeedback() {
    feedbackForm.display(
      context,
      option: Option(
        //shape: const StarBorder.polygon(),
        hideRatingBottomText: true,
        maxRating: 5,
        ratingButtonTheme: RatingButtonThemeData.outlinedBorder(),
      ),
      onSubmit: (feedback) {
        this.feedback = feedback;
        setState(
          () {
            SendfeedBack;
          },
        );
      },
    );
  }

  Future<bool> get SendfeedBack {
    return UrlLauncher.launch(
        'https://wa.me/923203608044?text=Name:  ${loggedInUser!.name} \nRating: ${feedback!.rating}/5 \nReview: ${feedback!.review}');
  }

  bool get feedbackAvailable => feedback != null && feedback!.rating != null;

  //
  //Shared Preference start
  bool _hasDengue = false;

  @override
  void initState() {
    //FeedBack Code Starts
    feedbackForm.init(
      FeedbackConfig(
        duration: const Duration(seconds: 10),
        displayLogs: true,
      ),
    );
    //FeedBack Code Ends
    super.initState();
    _loadDarkModeSetting();
  }

  void _loadDarkModeSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasDengue = prefs.getBool('Has_Dengue') ?? false;
    });
  }

  // ignore: non_constant_identifier_names
  void _DengueStatussetting(bool value, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Has_Dengue', value);
    if (value == true) {
      updateUserStatus(context, loggedInUser!.user_id, _hasDengue);
    }
  }

  //Shared Preference End
  //User? u = loggedInUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 249, 242, 242),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            // user card
            BigUserCard(
              cardRadius: 20,
              backgroundMotifColor: const Color.fromRGBO(255, 255, 255, 1),
              //settingColor: Colors.amber,
              userName: loggedInUser!.name,
              // userProfilePic: null,
              userProfilePic: NetworkImage(
                loggedInUser!.image != null
                    ? imgpath + loggedInUser!.image!
                    : "https://e7.pngegg.com/pngimages/771/79/png-clipart-avatar-bootstrapcdn-graphic-designer-angularjs-avatar-child-face.png",
              ),

              userMoreInfo: TextWidget(
                title: loggedInUser!.email,
                txtSize: 10,
                txtColor: txtColor,
              ),
              role: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: loggedInUser!.role == "admin"
                          ? tbtnColor
                          : loggedInUser!.role == "officer"
                              ? greenColor
                              : loggedInUser!.role == "user"
                                  ? txtColor
                                  : ScfColor,
                      shadowColor: const Color.fromARGB(255, 255, 255, 255),
                      //elevation: 5,
                    ),
                    onPressed: (() {}),
                    child: Text(
                      loggedInUser!.role,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: btnColor,

              cardActionWidget: SettingsItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileEditScreen(),
                    ),
                  );
                },
                icons: CupertinoIcons.pencil,
                iconStyle: IconStyle(
                  backgroundColor: btnColor,
                ),
                title: 'Modify',
                subtitle: "Tap here to change your data",
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    //Dialog
                    showDialog(
                      //useSafeArea: true,
                      //To disable alert background
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        //title: const Text("Alert Dialog Box"),
                        //content: const Text("Do you want to login?"),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                            ],
                          ),
                          Container(
                            height: 45,
                            width: 400,
                            decoration: BoxDecoration(
                              color: btnColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                //right: 5,
                                bottom: 10,
                                left: 15,
                              ),
                              child: TextWidget(
                                title: "Area Range",
                                txtSize: 20,
                                txtColor: bkColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                  title: "1 KM",
                                  txtSize: 13,
                                  txtColor: txtColor),
                              const SizedBox(
                                width: 160,
                              ),
                              TextWidget(
                                  title: "10 KM",
                                  txtSize: 13,
                                  txtColor: txtColor),
                            ],
                          ),
                          const SizedBox(
                            width: 380,
                            child: RangeSlidr(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const OfficersListScreen(),
                                  //     ),
                                  // );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: const TextWidget(
                                      title: "Cancel",
                                      txtSize: 15,
                                      txtColor: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    range = null;
                                    // _currentSliderValue=null;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: const TextWidget(
                                      title: "Save",
                                      txtSize: 15,
                                      txtColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );

                    //
                  },
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Prefrences',
                  subtitle: "Tap here to set area radius",
                ),
                SettingsItem(
                  backgroundColor: btnColor,
                  onTap: () {
                    getDialogue(context, "No sectors created yet in API!");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const Add_Sector_Screen(),
                    //   ),
                    // );
                  },
                  icons: Icons.admin_panel_settings_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Sectors',
                  subtitle: "Edit Sectors data",
                ),
                loggedInUser!.role == "admin"
                    ? SettingsItem(
                        backgroundColor: btnColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OfficersListScreen(),
                            ),
                          );
                        },
                        icons: Icons.admin_panel_settings_rounded,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: Colors.red,
                        ),
                        title: 'Officers',
                        subtitle: "Edit Sectors & Officers data",
                      )
                    : loggedInUser!.role == "officer"
                        ? SettingsItem(
                            backgroundColor: btnColor,
                            onTap: () {
                              getDialogue(context, "No sectors assigned!");
                            },
                            icons: Icons.area_chart_rounded,
                            iconStyle: IconStyle(
                              iconsColor: Colors.white,
                              withBackground: true,
                              backgroundColor: Colors.red,
                            ),
                            title: 'Sectors',
                            subtitle: "View your assigned Sectors",
                          )
                        : SettingsItem(
                            backgroundColor: btnColor,
                            onTap: () {
                              getDialogue(context, "Your are not authorized!");
                            },
                            icons: Icons.area_chart_rounded,
                            iconStyle: IconStyle(
                              iconsColor: Colors.white,
                              withBackground: true,
                              backgroundColor: Colors.red,
                            ),
                            title: 'Sectors',
                            subtitle: "Edit Sectors & Officers data",
                          ),
                SettingsItem(
                  onTap: () {},
                  icons: _hasDengue
                      ? Icons.sentiment_very_dissatisfied
                      : Icons.emoji_emotions_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Status',
                  subtitle: "Do you have Dengue?",
                  trailing: Switch.adaptive(
                    inactiveTrackColor:
                        const Color.fromARGB(255, 255, 255, 255),
                    inactiveThumbColor:
                        const Color.fromARGB(255, 246, 195, 195),
                    //enableFeedback: true,
                    activeColor: btnColor,
                    value: _hasDengue,
                    onChanged: (value) {
                      setState(
                        () {
                          _hasDengue = value;
                          _DengueStatussetting(value, context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AboutUs_Screen(),
                      ),
                    );
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about us",
                ),
                SettingsItem(
                  onTap: () {
                    launchAppFeedback();
                  },
                  icons: CupertinoIcons.chat_bubble_fill,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.amber,
                  ),
                  title: 'Send Feedback',
                  subtitle: "Let us know how we can improve our applicaton",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    // setState(() {
                    //   emailsaved = "";
                    //   passwordsaved = "";
                    //   //loggedInUser = null;
                    // });

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  icons: Icons.exit_to_app_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
                  title: "Log Out",
                  subtitle: "You will be logged out.",
                ),

                // SettingsItem(
                //   onTap: () {},
                //   icons: CupertinoIcons.repeat,
                //   title: "Change email",
                // ),
                SettingsItem(
                  onTap: () {
                    //Dialog
                    showDialog(
                      //useSafeArea: true,
                      //To disable alert background
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        //title: const Text("Alert Dialog Box"),
                        //content: const Text("Do you want to login?"),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            title: "Do you want to delete your account?",
                            txtSize: 20,
                            txtColor: txtColor,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const OfficersListScreen(),
                                  //     ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: const TextWidget(
                                      title: "No",
                                      txtSize: 15,
                                      txtColor: Colors.white),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: btnColor,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                    vertical: 10,
                                  ),
                                  child: const TextWidget(
                                      title: "Yes",
                                      txtSize: 15,
                                      txtColor: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  icons: CupertinoIcons.delete_solid,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.redAccent,
                  ),
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: "Your data will be be removed.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
