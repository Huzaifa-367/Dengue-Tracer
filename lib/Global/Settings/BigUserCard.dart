import 'package:flutter/material.dart';

class BigUserCard extends StatelessWidget {
  Color? backgroundColor;
  Color? settingColor;
  double? cardRadius;
  Color? backgroundMotifColor;
  Widget? cardActionWidget;
  String? userName;
  Widget? role;
  Widget? userMoreInfo;
  ImageProvider? userProfilePic;

  BigUserCard({
    super.key,
    this.backgroundColor,
    this.settingColor,
    this.cardRadius = 30,
    required this.userName,
    this.role,
    this.backgroundMotifColor = Colors.white,
    this.cardActionWidget,
    this.userMoreInfo,
    required this.userProfilePic,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    if (userMoreInfo == null) userMoreInfo = Container();
    return Container(
      height: mediaQueryHeight / 3.5,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(double.parse(cardRadius!.toString())),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: backgroundMotifColor!.withOpacity(.1),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 400,
              backgroundColor: backgroundMotifColor!.withOpacity(.05),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: (cardActionWidget != null)
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // User profile
                    Expanded(
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: mediaQueryHeight / 13,
                          backgroundImage: userProfilePic!,
                        ),
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
                                  child: Image(
                                    image: userProfilePic!,
                                  ),
                                ),
                              ],
                            ),
                          );

                          //
                        },
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          userMoreInfo!,
                          role!,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: settingColor ?? Theme.of(context).cardColor,
                  ),
                  child: (cardActionWidget != null)
                      ? cardActionWidget
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
