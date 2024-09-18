import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class ProjectLink extends StatelessWidget {
  final String title;
  final Icon icon;
  const ProjectLink({super.key, required this.title,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}