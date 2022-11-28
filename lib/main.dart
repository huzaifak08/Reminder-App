import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/create_reminder.dart';
import 'package:firebase_learn/home.dart';
import 'package:firebase_learn/login.dart';
import 'package:firebase_learn/routes.dart';
import 'package:firebase_learn/signup.dart';
import 'package:firebase_learn/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginPageRoute: (context) => LoginPage(),
        signupPageRoute: (context) => SignupPage(),
        splashScreenRoute: (context) => SplashScreen(),
        homePageRoute: (context) => HomePage(),
        CreateReminderRoute: (context) => CreateReminderPage(),
      },
    );
  }
}
