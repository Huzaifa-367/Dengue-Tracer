import 'dart:io';

import 'package:dengue_tracing_application/Global/SnackBar_widget.dart';
import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';
import 'package:dengue_tracing_application/model/OFFICER/Officer_API.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart' as sector;
import 'package:http/http.dart' as http;
import 'dart:convert';

class OfficerAddScreen extends StatefulWidget {
  const OfficerAddScreen({Key? key}) : super(key: key);

  @override
  State<OfficerAddScreen> createState() => _OfficerAddScreenState();
}

class _OfficerAddScreenState extends State<OfficerAddScreen> {
  TextEditingController namecont = TextEditingController();
  TextEditingController phonecont = TextEditingController();
  TextEditingController emailcont = TextEditingController();
  TextEditingController passwordcont = TextEditingController();
  TextEditingController passwordcont2 = TextEditingController();
  bool isVisible = true;
  String role = 'officer';

  /// Variables
  File? imageFile;

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  /// Get from Camera
  _getFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  List<String>? sectors;
  List<String>? selectedDataString;
  int? selectedSectorId;

  Future<List<String>> fetchSectors() async {
    final response = await http.get(Uri.parse('$ip/GetSectors'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final sectors = jsonData
          .map((e) => e['sec_name'] != null ? e['sec_name'].toString() : '')
          .toList();
      return sectors;
    } else {
      throw Exception("Failed to fetch sectors data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: btnColor,
            title: TextWidget(
                title: "Add New Health Inspector",
                txtSize: 20,
                txtColor: txtColor),
          ),
          //backgroundColor: Colors.amber,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Divider(color: btnColor, thickness: 2),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      Stack(
                        children: [
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
                                  backgroundImage: AssetImage(Images.dpImage),
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
                                              XFile? file = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.gallery);
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
                                                  await ImagePicker().pickImage(
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
                    ],
                  ),
                  const SizedBox(
                    height: 30,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: FutureBuilder<List<String>>(
                      future: fetchSectors(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          sectors = snapshot.data;
                          return sector.CustomSingleSelectField<String>(
                            title: "Sectors",
                            items: sectors!,
                            //enableAllOptionSelect: true,
                            onSelectionDone: _onSelectionComplete,
                            itemAsString: (item) => item.toString(),
                          );
                        } else if (snapshot.hasError) {
                          return const Text("Error fetching sectors data");
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
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
                        btnText: "Save",
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
                            u.home_location = "";

                            await AddOfficer(
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

  void _onSelectionComplete(dynamic value) {
    int selectedSectorId = value as int;
    setState(() {
      // set the state of your widget with the selected sector ID
    });
  }
}
