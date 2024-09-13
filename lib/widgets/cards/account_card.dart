import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class AccountCard extends StatelessWidget {
  const AccountCard(
      {super.key, required this.title, this.icon, this.onPressed});

  final String title;
  final Icon? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 27),
      width: context.getWidth(divideBy: 1.1),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Color(0xff4D2EB4), offset: Offset(2, 4))
          ],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff4931AF), width: 2)),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Lato"),
        ),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.arrow_outward_outlined)),
      ),
    );
  }
}
