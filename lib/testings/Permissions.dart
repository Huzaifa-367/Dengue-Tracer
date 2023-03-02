import 'package:dengue_tracing_application/screens/Authentication/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerScreen extends StatefulWidget {
  const PermissionHandlerScreen({super.key});

  @override
  _PermissionHandlerScreenState createState() =>
      _PermissionHandlerScreenState();
}

class _PermissionHandlerScreenState extends State<PermissionHandlerScreen> {
  @override
  void initState() {
    super.initState();
    permissionServiceCall();
  }

  permissionServiceCall() async {
    await permissionServices().then(
      (value) {
        if (value[Permission.location]!.isGranted) {
          // if (value[Permission.location]!.isGranted &&
          //     value[Permission.camera]!.isGranted &&
          //     value[Permission.photos]!.isGranted &&
          //     value[Permission.storage]!.isGranted) {
          /* ========= New Screen Added  ============= */

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
    );
  }

  /*Permission services*/
  Future<Map<Permission, PermissionStatus>> permissionServices() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      //Permission.camera,
      //Permission.storage,
      //Permission.photos,

      //add more permission to request here.
    ].request();

    if (statuses[Permission.location]!.isPermanentlyDenied) {
      await openAppSettings().then(
        (value) async {
          if (value) {
            if (await Permission.location.status.isPermanentlyDenied == true &&
                await Permission.location.status.isGranted == false) {
              // openAppSettings();
              permissionServiceCall(); /* opens app settings until permission is granted */
            }
          }
        },
      );
    } else {
      if (statuses[Permission.location]!.isDenied) {
        permissionServiceCall();
      }
    }

    /*{Permission.camera: PermissionStatus.granted, Permission.storage: PermissionStatus.granted}*/
    return statuses;
  }

  @override
  Widget build(BuildContext context) {
    permissionServiceCall();
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        throw "";
      },
      child: Scaffold(
        body: Container(
          child: Center(
            child: InkWell(
                onTap: () {
                  permissionServiceCall();
                },
                child: const Text(
                    "Click here to enable Enable Permission Screen")),
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        throw "";
      },
      child: const Scaffold(
        body: Center(
          child: Text(
            "Splash Screen",
          ),
        ),
      ),
    );
  }
}
