import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class RatingField extends StatelessWidget {
  final String title;
  final Icon iconToAdd;
  final HomeCubit cubit;

  const RatingField({
    super.key,
    required this.title,
    required this.iconToAdd, required this.cubit,
  });

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
            RatingStars(
              valueLabelVisibility: false,
              onValueChanged: (value) => cubit.changeStars(value),
                                    starColor: Colors.yellow,
                                    starCount: 10,
                                    value: 2,
                                  )
          ],
        ),
      ],
    );
  }
}
