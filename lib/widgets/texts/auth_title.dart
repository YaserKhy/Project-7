import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return  Text(
      title
      ,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Color(0xff4D2EB4),
          fontFamily: "Lato"),
    );
  }
}
