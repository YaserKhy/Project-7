import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class ViewProjectTitle extends StatelessWidget {
  final String title;
  const ViewProjectTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            color: AppConstants.mainPurple
          )
        ),
        const Divider(),
      ],
    );
  }
}
