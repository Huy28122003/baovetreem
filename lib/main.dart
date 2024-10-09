import 'package:app_usage/app_usage.dart';
import 'package:bao_ve_tre_em/models/App.dart';
import 'package:bao_ve_tre_em/options.dart';
import 'package:bao_ve_tre_em/services/default_data.dart';
import 'package:bao_ve_tre_em/services/firebase_parent.dart';
import 'package:bao_ve_tre_em/welcome.dart';
import 'package:bao_ve_tre_em/parent/dash_board.dart';
import 'package:bao_ve_tre_em/parent/sign_in.dart';
import 'package:bao_ve_tre_em/parent/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((taskName, inputData) async {
    await Firebase.initializeApp();
    ParentService _p = ParentService();

    DateTime endDate = DateTime.now();
    DateTime startDate =
    DateTime(endDate.year, endDate.month, endDate.day, 00, 00, 00);
    List<AppUsageInfo> infoList =
    await AppUsage().getAppUsage(startDate, endDate);
    List<App> app = [];
    for (var info in infoList) {
      print("${info.toString()} ooooooooooo");
      App ap =
      App(info.packageName, false, info.usage.toString(), info.appName);
      app.add(ap);
    }
    _p.pushAppUsage(app);
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DefaultData.initialize();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerPeriodicTask("jj", "Ok",
      frequency: Duration(minutes: 15), initialDelay: Duration(seconds: 1));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/options': (context) => const Options(),
        '/signIn': (context) => const SignIn(),
        '/signUp': (context) => const SignUp(),
        '/dashBoard': (context) => const DashBoard()
      },
    );
  }
}
