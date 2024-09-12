import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.title, this.onPressed});

  final String title;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(color: Color(0xff4D2EB4), offset: Offset(2, 4))
          ]),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: const BorderSide(color: Color(0xff4D2EB4), width: 2)),
              foregroundColor: const Color(0xff4D2EB4),
              fixedSize: Size(context.getWidth() / 1.1, 60),
              textStyle: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          onPressed: onPressed,
          child: Text(title)),
    );
  }
}