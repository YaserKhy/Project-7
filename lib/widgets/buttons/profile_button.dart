import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, required this.title, this.onPressed, required this.color, this.icon});
  final String title;
  final Color color;
  final IconData? icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextButton(
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(icon, color: color),
              const SizedBox(width: 10),
              Text(title,
                  style:  TextStyle(
                      fontSize: 20,
                      fontFamily: "Lato",
                      color: color)),
            ],
          )),
    );
  }
}
