import 'dart:io';

import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Authentication/models/usermodel.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  //Shared Preference start
  bool _hasDengue = false;

  @override
  void initState() {
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
  void _DengueStatussetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('Has_Dengue', value);
  }

  //Shared Preference End

  TextEditingController namecont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  TextEditingController home_loccont = TextEditingController();
  // TextEditingController office_loccont = TextEditingController();

  // /// Get from gallery
  // _getFromGallery() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   setState(() {
  //     imageFile = File(pickedFile!.path);
  //   });
  // }

  // /// Get from Camera
  // _getFromCamera() async {
  //   XFile? pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.camera);

  //   setState(() {
  //     imageFile = File(pickedFile!.path);
  //     imageFile = File(pickedFile.path);
  //     u.uploadPic(imageFile!);
  //   });
  // }
  /// Variables
  User? u;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          //backgroundColor: ScfColor,
          body: Padding(
            padding: const EdgeInsets.only(
              //left: 10.0,
              //right: 10,
              top: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                          ),
                          Stack(
                            children: [
                              // const CircleAvatar(
                              //   radius: 50,
                              // backgroundImage: u!.image == null
                              //     ? null
                              //     : NetworkImage(imgpath + u!.image!),
                              // backgroundImage: u!.image == null
                              //     ? const NetworkImage(
                              //         "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png")
                              //     : NetworkImage(imgpath + u!.image!),
                              //),
                              imageFile == null
                                  ? CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          imgpath + loggedInUser!.image!),
                                    )
                                  : const CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage(Images.dpImage),
                                    ),
                              Positioned(
                                bottom: 0.2,
                                right: 0.2,
                                //left: 50,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: (() {
                                                  Navigator.of(context).pop();
                                                }),
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextWidget(
                                                  title: "Pick Image From?",
                                                  txtSize: 20,
                                                  txtColor: btnColor),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () async {
                                                  XFile? file =
                                                      await ImagePicker()
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                  if (file != null) {
                                                    imageFile = File(file.path);
                                                    loggedInUser!
                                                        .uploadPic(imageFile!);
                                                  }

                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: btnColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          right: 8,
                                                          bottom: 10,
                                                          left: 8),
                                                  child: const TextWidget(
                                                      title: "Gallery",
                                                      txtSize: 15,
                                                      txtColor: Colors.white),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  XFile? file =
                                                      await ImagePicker()
                                                          .pickImage(
                                                    source: ImageSource.camera,
                                                  );
                                                  if (file != null) {
                                                    imageFile = File(file.path);
                                                    loggedInUser
                                                        ?.uploadPic(imageFile!);
                                                  }

                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: btnColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10,
                                                          right: 8,
                                                          bottom: 10,
                                                          left: 8),
                                                  child: const TextWidget(
                                                      title: "  Camera  ",
                                                      txtSize: 15,
                                                      txtColor: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    //size: 35,
                                    Icons.camera_alt,
                                    size: 35,
                                    color: btnColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          //   GestureDetector(
                          //     onTap: () {
                          //       //Dialog
                          //       showDialog(
                          //         //useSafeArea: true,
                          //         //To disable alert background
                          //         barrierDismissible: false,
                          //         context: context,
                          //         builder: (context) => AlertDialog(
                          //           //title: const Text("Alert Dialog Box"),
                          //           //content: const Text("Do you want to login?"),
                          //           actions: <Widget>[
                          //             Row(
                          //               mainAxisAlignment: MainAxisAlignment.end,
                          //               children: [
                          //                 IconButton(
                          //                   onPressed: (() {
                          //                     Navigator.of(context).pop();
                          //                   }),
                          //                   icon:
                          //                       const Icon(Icons.cancel_outlined),
                          //                 ),
                          //               ],
                          //             ),
                          //             Container(
                          //               height: 45,
                          //               width: 400,
                          //               decoration: BoxDecoration(
                          //                 color: btnColor,
                          //                 borderRadius: BorderRadius.circular(25),
                          //               ),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     top: 10,
                          //                     //right: 5,
                          //                     bottom: 10,
                          //                     left: 15),
                          //                 child: TextWidget(
                          //                     title: "Area Range Of Users",
                          //                     txtSize: 20,
                          //                     txtColor: bkColor),
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 10,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 TextWidget(
                          //                     title: "1 KM",
                          //                     txtSize: 13,
                          //                     txtColor: txtColor),
                          //                 const SizedBox(
                          //                   width: 160,
                          //                 ),
                          //                 TextWidget(
                          //                     title: "10 KM",
                          //                     txtSize: 13,
                          //                     txtColor: txtColor),
                          //               ],
                          //             ),
                          //             const SizedBox(
                          //               width: 380,
                          //               child: RangeSlidr(),
                          //             ),
                          //             Container(
                          //               height: 45,
                          //               width: 400,
                          //               decoration: BoxDecoration(
                          //                 color: btnColor,
                          //                 borderRadius: BorderRadius.circular(25),
                          //               ),
                          //               child: Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     top: 10,
                          //                     // right: 5,
                          //                     bottom: 10,
                          //                     left: 15),
                          //                 child: TextWidget(
                          //                     title:
                          //                         "Threshold For Dengue Cases?",
                          //                     txtSize: 20,
                          //                     txtColor: bkColor),
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 10,
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 0),
                          //               child: MyTextField(
                          //                 controller: emailcontr,
                          //                 hintText: "100 - 100000",
                          //                 keytype: TextInputType.number,
                          //                 obscureText: false,
                          //                 prefixIcon: const Icon(Icons.numbers),
                          //                 //sufixIcon: Icons.remove_red_eye,
                          //               ),
                          //             ),
                          //             const SizedBox(
                          //               height: 10,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 TextButton(
                          //                   onPressed: () {
                          //                     Navigator.push(
                          //                         context,
                          //                         MaterialPageRoute(
                          //                           builder: (context) =>
                          //                               const OfficersListScreen(),
                          //                         ));
                          //                   },
                          //                   child: Container(
                          //                     decoration: BoxDecoration(
                          //                       color: btnColor,
                          //                       borderRadius:
                          //                           BorderRadius.circular(25),
                          //                     ),
                          //                     padding: const EdgeInsets.only(
                          //                         top: 10,
                          //                         right: 8,
                          //                         bottom: 10,
                          //                         left: 8),
                          //                     child: const TextWidget(
                          //                         title: "View Health Inspector",
                          //                         txtSize: 15,
                          //                         txtColor: Colors.white),
                          //                   ),
                          //                 ),
                          //                 TextButton(
                          //                   onPressed: () {
                          //                     Navigator.of(context).pop();
                          //                   },
                          //                   child: Container(
                          //                     decoration: BoxDecoration(
                          //                       color: btnColor,
                          //                       borderRadius:
                          //                           BorderRadius.circular(25),
                          //                     ),
                          //                     padding: const EdgeInsets.only(
                          //                         top: 10,
                          //                         right: 8,
                          //                         bottom: 10,
                          //                         left: 8),
                          //                     child: const TextWidget(
                          //                         title: "  Save  ",
                          //                         txtSize: 15,
                          //                         txtColor: Colors.white),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //     child: Icon(
                          //       //size: 35,
                          //       Icons.settings,
                          //       size: 35,
                          //       color: btnColor,
                          //     ),
                          //   ),
                          //

                          //
                          //
                          //
                          //
                          //
                          //
                          //
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 140,
                      ),
                      Text(
                        loggedInUser!.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: 35,
                        width: 60,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: loggedInUser!.role == "admin"
                                ? btnColor
                                : loggedInUser!.role == "Officer"
                                    ? greenColor
                                    : loggedInUser!.role == "user"
                                        ? txtColor
                                        : ScfColor,
                            shadowColor:
                                const Color.fromARGB(255, 196, 120, 115),
                            //elevation: 4,
                          ),
                          onPressed: (() {}),
                          child: Text(
                            loggedInUser!.role,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    loggedInUser!.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: namecont,
                      hintText: "Name",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.person),
                      //sufixIcon: Icons.remove_red_eye,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: emailcont,
                      hintText: "Email",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email),
                      //sufixIcon: Icons.remove_red_eye,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: phonecont,
                      hintText: "Phone Number",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.call),
                      // sufixIcon: Icons.remove_red_eye,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: passwordcont,
                      hintText: "Password",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.password),
                      sufixIcon: Icons.remove_red_eye,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: passwordcont,
                      hintText: "Repeat Password",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.password),
                      sufixIcon: Icons.remove_red_eye,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: MyTextField(
                      controller: home_loccont,
                      hintText: "Location",
                      keytype: TextInputType.text,
                      obscureText: false,
                      prefixIcon: const Icon(Icons.map),
                      sufixIcon: Icons.pin_drop,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width / 1.2,
                  //       child: SwitchListTile(
                  //         inactiveTrackColor:
                  //             const Color.fromARGB(255, 208, 233, 201),
                  //         inactiveThumbColor:
                  //             const Color.fromARGB(255, 75, 222, 7),
                  //         //enableFeedback: true,
                  //         activeColor: btnColor,
                  //         title: TextWidget(
                  //             title: "Do You Have Dengue?",
                  //             txtSize: 23,
                  //             txtColor: txtColor),
                  //         value: _hasDengue,
                  //         onChanged: ((value) {
                  //           setState(
                  //             () {
                  //               _hasDengue = value;
                  //               _DengueStatussetting(value);
                  //             },
                  //           );
                  //         }),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      width: 300,
                      child: ButtonWidget(
                        btnText: "Save",
                        onPress: (() {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        }),
                      ),
                    ),
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
