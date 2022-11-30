import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/firebase_options.dart';
import 'package:firebase_learn/login.dart';
import 'package:firebase_learn/round_button.dart';
import 'package:firebase_learn/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                        return 'Enter your Email';
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
                        return 'Enter your Password';
                      } else
                        null;
                    },
                  ),
                  SizedBox(height: 25),
                  RoundButton(
                    title: 'Sign UP',
                    loading: loading,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                  ),
                  SizedBox(height: 12),

                  // Already have an Account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login In',
                            style: TextStyle(color: Color(0xFFF2796B)),
                          ))
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

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text.toString(),
      password: _passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage('Account Created Successfully');
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
}
