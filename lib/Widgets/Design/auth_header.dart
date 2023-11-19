import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  const AuthHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                height: 2,
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image.asset(
                'assets/images/User.png',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Make your life easier with us',
            style: TextStyle(color: Color(0xFF5B5B5B)),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
