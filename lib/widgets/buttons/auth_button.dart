import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.title, this.onPressed});
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: title=="Delete" ? AppConstants.red : AppConstants.mainPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor: Colors.white,
        fixedSize: const Size(350, 45),
        textStyle: const TextStyle(fontFamily: "Lato",fontSize: 18,fontWeight: FontWeight.bold)
      ),
      child: Text(title)
    );
  }
}