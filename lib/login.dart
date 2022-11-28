import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:firebase_learn/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return SingleChildScrollView(
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
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'someone@gmail.com',
                        ),
                        keyboardType: TextInputType.emailAddress,
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
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "abc123",
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        height: 43,
                        width: 367,
                        child: ElevatedButton(
                          onPressed: () {
                            final email = _email.text;
                            final password = _password.text;

                            try {
                              final userCredential = FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                print('User Not Found');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong Password Entered');
                              }
                            }
                          },
                          child: Text('Log In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF2796B),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(text: 'Do not have an account? '),
                            TextSpan(
                                text: 'Create new account',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => SignupPage(),
                                    ));
                                  })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          default:
            return Text('Loading');
        }
      },
    ));
  }
}
