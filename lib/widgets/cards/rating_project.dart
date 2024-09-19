import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class RatingField extends StatelessWidget {
  final String title;
  final Icon iconToAdd;

  const RatingField({
    super.key,
    required this.title,
    required this.iconToAdd,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..showStars(),
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              iconToAdd,
              const SizedBox(width: 10),
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
                  BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    final cubit = context.read<HomeCubit>();
    
    // Display stars based on both the show state and change state
    if (state is ShowStarsState || state is StarChangedState) {
      return RatingStars(
        valueLabelVisibility: false,
        onValueChanged: (value) => cubit.changeStars(title.toLowerCase(), value),
        starColor: Colors.yellow,
        starCount: 10,
        value: cubit.rating[title.toLowerCase()],
      );
    }
    return const SizedBox.shrink();
  },
)
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}
