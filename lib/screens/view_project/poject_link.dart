import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/helpers/url_launcher.dart';

class ProjectLink extends StatelessWidget {
  final String title;
  final Icon icon;
  final String? urlPath;
  const ProjectLink(
      {super.key, required this.title, required this.icon, this.urlPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (urlPath != null) {
          urlLuncher(urlPath);
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.5, color: AppConstants.blue),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppConstants.textGrayColor,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
