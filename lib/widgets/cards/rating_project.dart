import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class RatingField extends StatelessWidget {
  final String title;
  final Icon iconToAdd;

  const RatingField({
    Key? key,
    required this.title,
    required this.iconToAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconToAdd,
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text and icons to the left
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppConstants.mainPurple, // Example color
                fontSize: 16,
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.star_border_outlined,
                  color: Colors.black,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
