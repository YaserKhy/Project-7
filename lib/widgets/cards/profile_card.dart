import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppConstants.mainPurple,
                child: CircleAvatar(
                    radius: 48,
                    backgroundImage: shared
                        .handleProfilePage(
                            logoUrl: profile.imageUrl, context: context)
                        .image),
              )),
          const SizedBox(height: 8),
          Text('${profile.firstName} ${profile.lastName}',
              style: const TextStyle(
                  color: AppConstants.mainPurple,
                  fontSize: 20,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(profile.email, style: const TextStyle(fontFamily: "Lato")),
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
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: profile.id));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("ID copied to clipboard")));
                  },
                  icon: const Icon(Icons.copy, size: 20))
            ],
          )
        ],
      ),
    );
  }
}
