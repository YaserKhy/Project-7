import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton(
      {super.key, required this.text, required this.button, this.onPressed});
  final String text;
  final String button;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontFamily: "Lato"),
          ),
          TextButton(
              onPressed: () {},
              child: Text(button,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4D2EB4))))
        ],
      ),
    );
  }
}
