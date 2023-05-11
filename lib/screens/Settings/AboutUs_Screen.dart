// ignore_for_file: camel_case_types

import 'package:dengue_tracing_application/Global/Profile_Screen_Widgets.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUs_Screen extends StatefulWidget {
  const AboutUs_Screen({super.key});

  @override
  State<AboutUs_Screen> createState() => _AboutUs_ScreenState();
}

class _AboutUs_ScreenState extends State<AboutUs_Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          // backgroundColor: const Color.fromARGB(255, 249, 242, 242),
          // appBar: AppBar(
          //   title: const Text(
          //     "Settings",
          //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          //   ),
          //   centerTitle: true,
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                // user card
                BigUserCard(
                  cardRadius: 25,
                  backgroundMotifColor: Colors.white,
                  //settingColor: Colors.amber,
                  userName: "M.Huzaifa",
                  userProfilePic: const AssetImage(
                    "assets/images/huzaifa.png",
                  ),
                  // userMoreInfo: TextWidget(
                  //   title: "huzaifanawaz367@gmail.com",
                  //   txtSize: 13,
                  //   txtColor: txtColor,
                  // ),
                  role: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 35,
                      width: 160,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 248, 166, 166),
                          shadowColor: const Color.fromARGB(255, 255, 255, 255),
                          //elevation: 5,
                        ),
                        onPressed: (() {}),
                        child: Text(
                          "Developer",
                          style: GoogleFonts.gemunuLibre(
                            fontWeight: FontWeight.w900,
                            color: txtColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: btnColor,

                  cardActionWidget: SettingsItem(
                    backgroundColor: btnColor,
                    onTap: () {
                      UrlLauncher.launch('tel:+923203608044');
                    },
                    icons: Icons.call,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Phone',
                    subtitle: "+92 320 3608044",
                  ),
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      onTap: () {
                        UrlLauncher.launch('mailto:huzaifanawaz367@gmail.com');
                      },
                      icons: CupertinoIcons.mail,
                      iconStyle: IconStyle(
                        backgroundColor: btnColor,
                      ),
                      title: 'Email',
                      subtitle: "huzaifanawaz367@gmail.com",
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      backgroundColor: ScfColor2,
                      onTap: () {
                        String contact = "923203608044";
                        UrlLauncher.launch(
                            'https://wa.me/$contact?text=Hi, I need some help');
                      },
                      icons: CupertinoIcons.chat_bubble_fill,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.green,
                      ),
                      title: 'Whatsapp',
                      subtitle: "+92 320 3608044",
                    ),
                  ],
                ),
                SettingsGroup(
                  items: [
                    SettingsItem(
                      backgroundColor: ScfColor,
                      onTap: () {
                        UrlLauncher.launch('https://hub4web.com');
                      },
                      icons: CupertinoIcons.globe,
                      iconStyle: IconStyle(
                        iconsColor: Colors.white,
                        withBackground: true,
                        backgroundColor: Colors.blue,
                      ),
                      title: 'Website',
                      subtitle: "hub4web.com",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
