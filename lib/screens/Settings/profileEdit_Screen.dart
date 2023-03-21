import 'dart:io';

import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Authentication/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/USER/usermodel.dart';

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
    // namecont.text = loggedInUser!.name;
    // emailcont.text = loggedInUser!.email;
    // phonecont.text = loggedInUser!.phone_number;
    // passwordcont.text = loggedInUser!.password;
    // home_loccont.text = loggedInUser!.home_location;
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

  final TextEditingController namecont = TextEditingController();
  final TextEditingController phonecont = TextEditingController();
  final TextEditingController emailcont = TextEditingController();
  final TextEditingController passwordcont = TextEditingController();
  final TextEditingController home_loccont = TextEditingController();
  // TextEditingController office_loccont = TextEditingController();

  /// Variables
  User? u;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ScfColor,
          appBar: AppBar(
            backgroundColor: ScfColor,
            title: TextWidget(
              title: "Edit your profile",
              txtSize: 20,
              txtColor: txtColor,
            ),
          ),
          //backgroundColor: ScfColor,
          body: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Divider(
                    thickness: 2,
                    color: btnColor,
                  ),
                ),
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
                            //),
                            loggedInUser!.image != null
                                ? imageFile == null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            imgpath + loggedInUser!.image!),
                                      )
                                    : CircleAvatar(
                                        radius: 50,
                                        backgroundImage: FileImage(imageFile!),
                                      )
                                : const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        "https://e7.pngegg.com/pngimages/771/79/png-clipart-avatar-bootstrapcdn-graphic-designer-angularjs-avatar-child-face.png"),
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
                                                            source: ImageSource
                                                                .gallery);
                                                if (file != null) {
                                                  imageFile = File(file.path);
                                                  loggedInUser!
                                                      .uploadPic(imageFile!);
                                                }

                                                Navigator.of(context).pop();
                                                setState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: btnColor,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                padding: const EdgeInsets.only(
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
                                                      BorderRadius.circular(25),
                                                ),
                                                padding: const EdgeInsets.only(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                      btnText: "Save",
                      onPress: (() {
                        // loggedInUser!.name = namecont.text;
                        // loggedInUser!.email = emailcont.text;
                        // loggedInUser!.phone_number = phonecont.text;
                        // loggedInUser!.password = passwordcont.text;
                        // loggedInUser!.home_location = home_loccont.text;
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
    );
  }
}
