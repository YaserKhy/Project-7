import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class ProfileTitle extends StatelessWidget {
  final String title;
  const ProfileTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: AppConstants.mainPurple,
            fontSize: 20,
            fontFamily: "Lato",
            fontWeight: FontWeight.w500
          )
        ),
      ),
    );
  }
}