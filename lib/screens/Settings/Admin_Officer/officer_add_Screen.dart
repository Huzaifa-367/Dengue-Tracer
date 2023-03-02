import 'dart:io';

import 'package:dengue_tracing_application/Global/button_widget.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/Global/text_widget.dart';
import 'package:dengue_tracing_application/Global/txtfield_Round.dart';
import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/Utils/SectorsDropDown.dart';

import 'package:dengue_tracing_application/screens/Settings/Admin_Officer/officer_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OfficerAddScreen extends StatefulWidget {
  const OfficerAddScreen({Key? key}) : super(key: key);

  @override
  State<OfficerAddScreen> createState() => _OfficerAddScreenState();
}

class _OfficerAddScreenState extends State<OfficerAddScreen> {
  TextEditingController emailcontr = TextEditingController();

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
                txtSize: 25,
                txtColor: txtColor),
          ),
          //backgroundColor: Colors.amber,
          body: SingleChildScrollView(
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
                        imageFile == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage("assets/avatar-3.png"),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(imageFile!),
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                          onPressed: () {
                                            _getFromGallery();
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
                                                title: "  Gallery  ",
                                                txtSize: 15,
                                                txtColor: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _getFromCamera();
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
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextField(
                    controller: emailcontr,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextField(
                    controller: emailcontr,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextField(
                    controller: emailcontr,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextField(
                    controller: emailcontr,
                    hintText: "Password",
                    keytype: TextInputType.text,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.remove_red_eye),
                    sufixIcon: Icons.remove_red_eye,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyTextField(
                    controller: emailcontr,
                    hintText: "Repeat Password",
                    keytype: TextInputType.text,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.remove_red_eye),
                    sufixIcon: Icons.remove_red_eye,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SectorsDrop(),
                ),
                //
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
                      onPress: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OfficersListScreen()));
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
