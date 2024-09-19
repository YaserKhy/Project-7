import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;
  final Function()? onEdit;
  const ProfileCard({super.key, required this.profile, this.onEdit});
  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 268,
              height: 98,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage("assets/images/profile_decoration.png"))),
              child: Container(
                  height: 92,
                  width: 92,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppConstants.mainPurple),
                      image: DecorationImage(
                          image: shared
                              .handleProfilePage(
                                  logoUrl: profile.imageUrl, context: context)
                              .image)))),

          const SizedBox(height: 8),
          Text('${profile.firstName} ${profile.lastName}',
              style: const TextStyle(
                  color: AppConstants.mainPurple,
                  fontSize: 20,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Text(profile.role, style: const TextStyle(fontFamily: "Lato")),
          // Text(profile.email, style: const TextStyle(fontFamily: "Lato")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ID : ",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      color: AppConstants.mainPurple)),
              Text(profile.id,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontFamily: "Lato")),
            ],
          )
        ],
      ),
    );
  }
}