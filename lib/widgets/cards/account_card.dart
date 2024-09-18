import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/helpers/url_launcher.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onPressed;
  final String? urlPath;
  const AccountCard(
      {super.key,
      required this.title,
      this.icon,
      this.onPressed,
      this.urlPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: context.getWidth(divideBy: 1.06),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffC2C2C2))),
      ),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: "Lato",
              color: Color(0xff6D6D6D)),
        ),
        trailing: IconButton(
            onPressed: () {
              if (urlPath != null) {
                urlLuncher(urlPath);
              }
            },
            icon: const Icon(Icons.arrow_outward_outlined)),
      ),
    );
  }
}
