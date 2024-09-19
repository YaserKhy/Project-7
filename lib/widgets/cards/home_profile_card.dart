import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/profile_model.dart';

class HomeProfileCard extends StatelessWidget {
  final ProfileModel? profile;
  const HomeProfileCard({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    if(profile==null){
      return ListTile(
        leading: const SizedBox(
          width: 50,
          height: 50,
          child: CircleAvatar(backgroundColor: AppConstants.iconsGrayColor)
        ),
      title: const Text("Welcome"),
        titleTextStyle: const TextStyle(
        inherit: false,
        fontFamily: "Lato",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xffdadada)
      ),
      subtitle: Text('${profile?.firstName} ${profile?.lastName}  👋'),
      subtitleTextStyle: const TextStyle(
        inherit: false,
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: "Lato",
        color: Colors.white
      ),
    );
    }
    final shared = context.read<SharedCubit>();
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(color: AppConstants.iconsGrayColor, shape: BoxShape.circle),
        child: ClipOval(child: shared.handleLogo(logoUrl: profile!.imageUrl!, context: context))
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
