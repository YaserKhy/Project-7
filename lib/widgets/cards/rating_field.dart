import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart';

class RatingField extends StatelessWidget {
  final String title;
  final Icon iconToAdd;
  const RatingField({super.key,required this.title,required this.iconToAdd,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewProjectCubit()..showStars(),
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              iconToAdd,
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: const TextStyle(color: AppConstants.mainPurple,fontSize: 16)),
                  BlocBuilder<ViewProjectCubit, ViewProjectState>(
                    builder: (context, state) {
                      final cubit = context.read<ViewProjectCubit>();
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
