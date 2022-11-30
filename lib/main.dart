import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/CRUD%20Database/create_reminder.dart';
import 'package:firebase_learn/CRUD%20Database/home.dart';
import 'package:firebase_learn/authentication/login.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/routes.dart';
import 'package:firebase_learn/authentication/signup.dart';
import 'package:firebase_learn/Splash/splash_screen.dart';
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
      home: const SplashScreen(),
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
