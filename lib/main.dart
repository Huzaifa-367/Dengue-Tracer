import 'package:starlight_notification/starlight_notification.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';

Future<void> main() async {
  //notification testing
  WidgetsFlutterBinding.ensureInitialized();
  await StarlightNotificationService.setup();
  runApp(
    const DengueProject(),
  );
  //
  // runApp(
  //   MultiProvider(
  //     providers: const [
  //       // ChangeNotifierProvider(
  //       //   create: (_) => authController(),
  //       // ),
  //     ],
  //     child: const DengueProject(),
  //   ),
  // );
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
