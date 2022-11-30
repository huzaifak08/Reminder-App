import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/CRUD%20Database/home.dart';
import 'package:flutter/material.dart';

import '../Utils and Widgets/round_button.dart';
import '../Utils and Widgets/utils.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  final String verificationId;
  const VerifyPhoneNumberScreen({super.key, required this.verificationId});

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
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
                    'Verify Phone Number',
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
                  hintText: 'Enter 6 Digit Code',
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 50),
              RoundButton(
                title: 'Verify Code',
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });

                  // Firebase Verification:

                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: phoneController.text.toString(),
                  );
                  try {
                    await auth.signInWithCredential(credential);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
