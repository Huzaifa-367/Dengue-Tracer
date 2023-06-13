import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:provider/provider.dart';
import 'package:starlight_notification/starlight_notification.dart';
import 'package:dengue_tracing_application/Global/Widgets_Paths.dart';
import 'package:dengue_tracing_application/Global/Screen_Paths.dart';

import 'Test_Screens/DropDownController.dart';

Future<void> main() async {
  //notification testing
  WidgetsFlutterBinding.ensureInitialized();
  await StarlightNotificationService.setup();
  //
  // Initialize awesome_notifications package
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            importance: NotificationImportance.Max,
            channelKey: 'high_importance_channel',
            channelGroupKey: 'high_importance_channel',
            onlyAlertOnce: true,
            channelShowBadge: true,
            criticalAlerts: true,
            ledColor: Colors.white10,
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic test')
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'high_importance_channel_group',
            channelGroupName: 'Group 1')
      ],
      debug: true);
  // runApp(
  //   const DengueProject(),
  // );
  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DropDownController(),
        ),
        // ChangeNotifierProvider(
        //   create: (_) => authController(),
        // ),
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
