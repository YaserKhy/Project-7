import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key, required this.title, required this.color, this.onPressed});
  final String title;
  final Color color;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            foregroundColor: Colors.white,
            backgroundColor: color,
            fixedSize: const Size(200, 45)),
        onPressed: () {},
        child: Text(title,
            style: const TextStyle(fontSize: 16, fontFamily: "Lato")));
  }
}