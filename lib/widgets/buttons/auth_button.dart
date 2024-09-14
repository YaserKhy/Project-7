import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/constants/app_constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.title, this.onPressed});
  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [BoxShadow(color: AppConstants.mainPurple, offset: Offset(2, 4))]
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: AppConstants.mainPurple, width: 2)
          ),
          foregroundColor: AppConstants.mainPurple,
          fixedSize: Size(context.getWidth() / 1.1, 54),
          textStyle: const TextStyle(fontFamily: "Lato",fontSize: 18,fontWeight: FontWeight.bold)
        ),
        child: Text(title)
      ),
    );
  }
}