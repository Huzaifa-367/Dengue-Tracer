import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';
import 'package:dengue_tracing_application/Global/Packages_Path.dart';
import 'package:dengue_tracing_application/model/USER/User_API.dart';
import 'package:dengue_tracing_application/model/USER/usermodel.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    // namecont.text = loggedInUser!.name;
    // emailcont.text = loggedInUser!.email;
    // phonecont.text = loggedInUser!.phone_number;
    // passwordcont.text = loggedInUser!.password;
    // home_loccont.text = loggedInUser!.home_location;
    super.initState();
    getAddress();
    // _loadDarkModeSetting();
  }

  Future<void> getAddress() async {
    try {
      // Get the user's current location
      //LocationData locationData = await _location.getLocation();
      LatLng userLocation = LatLng(
        double.parse(loggedInUser!.home_location!.split(',')[0]),
        double.parse(loggedInUser!.home_location!.split(',')[1]),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLocation.latitude, userLocation.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';
        home_loccont.text = address;
      } else {
        home_loccont.text = "No address found";
      }
    } catch (e) {
      home_loccont.text = "Error getting address: ${e.toString()}";
    }
  }

  final TextEditingController namecont = TextEditingController(
    text: loggedInUser!.name,
  );
  final TextEditingController phonecont = TextEditingController(
    text: loggedInUser?.phone_number,
  );
  final TextEditingController emailcont = TextEditingController(
    text: loggedInUser!.email,
  );
  final TextEditingController passwordcont = TextEditingController(
    text: loggedInUser!.password,
  );
  final TextEditingController passwordcont2 = TextEditingController(
    text: loggedInUser!.password,
  );
  final TextEditingController home_loccont = TextEditingController();
  // TextEditingController office_loccont = TextEditingController();

  /// Variables
  int? sec_id;
  bool isVisible = true;
  bool isVisible2 = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScfColor,
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
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
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   //crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         const SizedBox(
                  //           width: 120,
                  //         ),
                  //         Stack(
                  //           children: [
                  //             //),
                  //             loggedInUser!.image != null
                  //                 ? imageFile == null
                  //                     ? CircleAvatar(
                  //                         radius: 50,
                  //                         backgroundImage: NetworkImage(
                  //                             imgpath + loggedInUser!.image!),
                  //                       )
                  //                     : CircleAvatar(
                  //                         radius: 50,
                  //                         backgroundImage: FileImage(imageFile!),
                  //                       )
                  //                 : const CircleAvatar(
                  //                     radius: 50,
                  //                     backgroundImage: NetworkImage(
                  //                         "https://e7.pngegg.com/pngimages/771/79/png-clipart-avatar-bootstrapcdn-graphic-designer-angularjs-avatar-child-face.png"),
                  //                   ),
                  //             Positioned(
                  //               bottom: 0.2,
                  //               right: 0.2,
                  //               //left: 50,
                  //               child: GestureDetector(
                  //                 onTap: () {
                  //                   showDialog(
                  //                     barrierDismissible: false,
                  //                     context: context,
                  //                     builder: (context) => AlertDialog(
                  //                       actions: <Widget>[
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.end,
                  //                           children: [
                  //                             IconButton(
                  //                               onPressed: (() {
                  //                                 Navigator.of(context).pop();
                  //                               }),
                  //                               icon: const Icon(Icons.cancel),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   );
                  //                 },
                  //                 child: Icon(
                  //                   //size: 35,
                  //                   Icons.camera_alt,
                  //                   size: 35,
                  //                   color: btnColor,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(
                  //           width: 60,
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   children: [
                  //     const SizedBox(
                  //       width: 140,
                  //     ),
                  //     Text(
                  //       loggedInUser!.name ?? "",
                  //       style: const TextStyle(
                  //         fontWeight: FontWeight.w700,
                  //         color: Colors.black,
                  //         fontSize: 25,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //   ],
                  // ),
                  // Text(
                  //   loggedInUser!.email ?? "",
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.w400,
                  //     color: Colors.black,
                  //     fontSize: 18,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
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
                    maxlines: 1,
                    controller: emailcont,
                    hintText: "Email",
                    keytype: TextInputType.text,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.email),
                    //sufixIcon: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    maxlines: 1,
                    controller: phonecont,
                    hintText: "Phone Number",
                    keytype: TextInputType.text,
                    obscureText: false,
                    prefixIcon: const Icon(Icons.call),
                    // sufixIcon: Icons.remove_red_eye,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextField(
                    maxlines: 1,
                    controller: passwordcont,
                    hintText: "Password",
                    keytype: TextInputType.text,
                    obscureText: isVisible,
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
                    controller: passwordcont2,
                    hintText: "Repeat Password",
                    keytype: TextInputType.text,
                    obscureText: isVisible2,
                    prefixIcon: const Icon(Icons.password),
                    sufixIconPress: () {
                      setState(() {
                        isVisible2 = !isVisible2;
                      });
                    },
                    sufixIcon:
                        isVisible2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: MyTextField_ReadOnly(
                  //     maxlines: 2,
                  //     readonly: true,
                  //     controller: home_loccont,
                  //     hintText: "Home Location",

                  //     sufixIconPress: () async {
                  //       //home_loccont.text = await
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (context) => const Homepage()));
                  //       // textController.text =
                  //       //     "${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}";
                  //       // Navigator.of(context).pop();
                  //     },
                  //     //prefixIcon: const Icon(Icons.map),
                  //     sufixIcon: Icons.arrow_forward_rounded,
                  //   ),
                  // ),
                  MyTextField_ReadOnly(
                    maxlines: 2,
                    readonly: true,
                    controller: home_loccont,
                    hintText: "Home Location",

                    sufixIconPress: () async {
                      var LocId = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PickLocation(),
                          //builder: (context) => const MapScreen(),
                        ),
                      );
                      setState(() {
                        String? LocSecid = LocId.split('-');
                        home_loccont.text = LocSecid![0];
                        sec_id = LocSecid[1] == "You,re not in our Sectors."
                            ? null
                            : int.parse(LocSecid[1]);
                      });

                      //builder: (context) => const Mapp_test()));
                      // textController.text =
                      //     "${cameraPosition.target.latitude}, ${cameraPosition.target.longitude}";
                      // Navigator.of(context).pop();
                    },
                    //prefixIcon: const Icon(Icons.map),
                    sufixIcon: Icons.arrow_forward_rounded,
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: 300,
                    child: ButtonWidget(
                      btnText: "Save",
                      onPress: (() async {
                        if (passwordcont.text == passwordcont2.text &&
                            namecont.text != "" &&
                            emailcont.text != "") {
                          User u = User();
                          //u.role = role;
                          u.name = namecont.text;
                          u.email = emailcont.text;
                          u.role = loggedInUser!.role;
                          u.phone_number = phonecont.text;
                          u.password = passwordcont.text;
                          u.home_location = home_loccont.text;
                          u.sec_id = sec_id;
                          await profileUpdate(
                            u,
                            context,
                          );
                        } else {
                          snackBar(context, "Please fill all fields correctly");
                        }
                      }),
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
