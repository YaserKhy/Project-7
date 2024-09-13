import 'package:flutter/material.dart';

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text( title,
            style: const TextStyle(
                color: Color(0xff4D2EB4),
                fontSize: 20,
                fontFamily: "Lato",
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
