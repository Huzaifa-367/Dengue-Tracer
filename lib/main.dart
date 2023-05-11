import 'package:dengue_tracing_application/Controller/NotificationController.dart';
import 'package:dengue_tracing_application/Global/constant.dart';
import 'package:dengue_tracing_application/screens/Welcome/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starlight_notification/starlight_notification.dart';

Future<void> main() async {
  //notification testing
  WidgetsFlutterBinding.ensureInitialized();
  await StarlightNotificationService.setup();

  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authController(),
        ),
      ],
      child: const DengueProject(),
    ),
  );
}

class DengueProject extends StatelessWidget {
  const DengueProject({Key? key}) : super(key: key);

  //const DengueProject({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: btnColor,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
