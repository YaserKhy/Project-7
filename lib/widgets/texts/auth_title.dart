import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String title;
  const AuthTitle({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: "Lato",
        fontSize: 25,
        fontWeight: FontWeight.w700,
        color: Color(0xff4D2EB4),
      ),
    );
  }
}
