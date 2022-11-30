import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/CRUD%20Database/home.dart';
import 'package:firebase_learn/authentication/login.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      );
    }
  }
}
