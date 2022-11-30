import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/authentication/login_with_phone.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/round_button.dart';
import 'package:firebase_learn/authentication/signup.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../CRUD Database/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // For not accepting null form:
  final _formKey = GlobalKey<FormState>();

  // Controllers:
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Firebase Authentication:
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Loading:
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          height: 2,
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Image.asset(
                          'assets/User.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Make your life easier with us',
                      style: TextStyle(color: Color(0xFF5B5B5B)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Container(
                      height: 231,
                      width: 296,
                      child: Image.asset('assets/login_img.png'),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Enter your Email Address',
                    style: TextStyle(
                      color: Color(0xFFF2796B),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'someone@gmail.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Email";
                      } else
                        null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Enter your Password',
                    style: TextStyle(
                      color: Color(0xFFF2796B),
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "abc123",
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password";
                      } else
                        null;
                    },
                  ),
                  SizedBox(height: 25),
                  RoundButton(
                    title: 'Sign In',
                    loading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signIn();
                      }
                    },
                  ),
                  SizedBox(height: 25),

                  // Login With Phone Number:
                  InkWell(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFF2796B), width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text(
                        'Login With Phone Number',
                        style: TextStyle(color: Color(0xFFF2796B)),
                      )),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWithPhoneScreen()));
                    },
                  ),
                  SizedBox(height: 12),

                  // Don't have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign UP',
                          style: TextStyle(color: Color(0xFFF2796B)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });

      Utils().toastMessage(value.user!.email.toString());

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });

      Utils().toastMessage(error.toString());
    });
  }
}
