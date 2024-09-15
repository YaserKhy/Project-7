import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class AuthTextButton extends StatelessWidget {
  final String text;
  final String button;
  final void Function()? onPressed;
  const AuthTextButton({super.key, required this.text, required this.button, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(text,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Lato")),
          TextButton(
            style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: onPressed,
            child: Text(
              button,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: "Lato",
                fontWeight: FontWeight.w700,
                color: AppConstants.mainPurple
              )
            )
          )
        ],
      ),
    );
  }
}