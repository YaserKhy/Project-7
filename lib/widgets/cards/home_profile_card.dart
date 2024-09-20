import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/profile_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeProfileCard extends StatelessWidget {
  final ProfileModel? profile;
  const HomeProfileCard({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    if (profile == null) {
      return ListTile(
        leading: SizedBox(
          width: 50,
          height: 50,
          child: ClipOval(
            child: Shimmer(
              child: const CircleAvatar(
                backgroundColor: AppConstants.iconsGrayColor
              )
            )
          )
        ),
        title: Row(
          children: [
            Shimmer(
              child: Container(
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 182, 182),
                borderRadius: BorderRadius.circular(20)),
                width: context.getWidth(divideBy: 4),
                height: 10
              )
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Shimmer(
              child: Container(
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 182, 182),
                borderRadius: BorderRadius.circular(20)),
                width: context.getWidth(divideBy: 4),
                height: 10
              )
            ),
          ],
        )
      );
    }
    // when done loading
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: AppConstants.iconsGrayColor,
          shape: BoxShape.circle
        ),
        child: ClipOval(
          child: shared.handleLogo(
            logoUrl: profile!.imageUrl!,
            context: context
          )
        )
      ),
      title: const Text("Welcome"),
      titleTextStyle: const TextStyle(
        inherit: false,
        fontFamily: "Lato",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xffdadada)
      ),
      subtitle: Text('${profile!.firstName} ${profile!.lastName}  👋'),
      subtitleTextStyle: const TextStyle(
        inherit: false,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: "Lato",
        color: Colors.white
      ),
    );
  }
}