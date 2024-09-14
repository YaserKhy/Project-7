import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/widgets/custom_icons_icons.dart';

class ProfileCard extends StatelessWidget {
  final ProfileModel profile;
  final ProfileCubit cubit;
  final Function()? onEdit;
  const ProfileCard(
      {super.key, required this.cubit, required this.profile, this.onEdit});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(divideBy: 1.03),
      child: Row(
        children: [
          SizedBox(
            height: 89,
            width: 89,
            child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: cubit
                    .handleProfilePage(
                        logoUrl: profile.imageUrl, context: context)
                    .image),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.getWidth(divideBy: 1.40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${profile.firstName} ${profile.lastName}',
                        style: const TextStyle(
                            color: AppConstants.mainPurple,
                            fontSize: 20,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold)),
                    IconButton(
                        onPressed: onEdit,
                        icon: const Icon(CustomIcons.edit,
                            color: AppConstants.mainPurple))
                  ],
                ),
              ),
              Text(profile.role, style: const TextStyle(fontFamily: "Lato")),
              Text(profile.email, style: const TextStyle(fontFamily: "Lato")),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ID : ",
                      style: TextStyle(
                          fontFamily: "Lato", fontWeight: FontWeight.bold)),
                  SizedBox(
                      width: context.getWidth(divideBy: 2),
                      child: Text(profile.id,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(fontFamily: "Lato"))),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
