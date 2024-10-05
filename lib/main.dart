import 'package:bao_ve_tre_em/options.dart';
import 'package:bao_ve_tre_em/services/default_data.dart';
import 'package:bao_ve_tre_em/welcome.dart';
import 'package:bao_ve_tre_em/parent/dash_board.dart';
import 'package:bao_ve_tre_em/parent/sign_in.dart';
import 'package:bao_ve_tre_em/parent/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DefaultData.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen (),
        '/options': (context) => const Options(),
        '/signIn': (context) => const SignIn(),
        '/signUp': (context)=>const SignUp(),
        '/dashBoard': (context) => const DashBoard()
      },
    );
  }
}

