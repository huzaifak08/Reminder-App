import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/round_button.dart';
import 'package:firebase_learn/Utils%20and%20Widgets/utils.dart';
import 'package:firebase_learn/authentication/verify_phone.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  // Firebase Auth:
  final auth = FirebaseAuth.instance;

  // Controller:
  final phoneController = TextEditingController();

  // loading:
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Login With Phone Number',
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
              SizedBox(height: 50),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '+92 340 0000000',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 50),
              RoundButton(
                title: 'Send Verification Code',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  // Firebase Authentication:
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (error) {
                      Utils().toastMessage(error.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      setState(() {
                        loading = false;
                      });

                      Utils().toastMessage('Code Send Successfully');

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyPhoneNumberScreen(
                                    verificationId: verificationId,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (error) {
                      Utils().toastMessage(error.toString());

                      setState(() {
                        loading = false;
                      });
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
