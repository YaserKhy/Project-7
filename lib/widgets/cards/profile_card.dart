import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.name,
      required this.cubit,
      required this.role,
      required this.email,
      required this.id,
      required this.profileImg});
  final String profileImg;
  final String name;
  final String role;
  final ProfileCubit cubit;
  final String email;
  final String id;
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
                    .handleProfilePage(logoUrl: profileImg, context: context)
                    .image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        color: Color(0xff4D2EB4),
                        fontSize: 20,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold)),
                Text(role,
                    style: const TextStyle(fontSize: 16, fontFamily: "Lato")),
                Text(
                  email,
                  style: const TextStyle(fontSize: 16, fontFamily: "Lato"),
                ),
                Row(
                  children: [
                    const Text("ID :",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold)),
                    Text(id,
                        style:
                            const TextStyle(fontSize: 15, fontFamily: "Lato"))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
