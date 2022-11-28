import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:firebase_learn/home.dart';
import 'package:firebase_learn/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
      // Initialize Firebase:
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
                            'Create Account',
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
                          onPressed: () async {
                            // Firebase:
                            final email = _email.text;
                            final password = _password.text;

                            try {
                              // Firebase userCrendentials:
                              final userCredential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password);

                              print(userCredential);

                              // Navigate to Home Page:
                              if (userCredential != null) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-email') {
                                print('Invalid Email');
                              } else if (e.code == 'email-already-in-use') {
                                print('Email Already in Use');
                              } else if (e.code == 'weak-password') {
                                print('Weak Password');
                              }
                            }
                          },
                          child: Text('Sign UP'),
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
                            TextSpan(text: 'Already have an account? '),
                            TextSpan(
                                text: 'Sign In',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
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
