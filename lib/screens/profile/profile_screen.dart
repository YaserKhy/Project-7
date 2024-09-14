import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/widgets/cards/account_card.dart';
import 'package:project7/widgets/cards/profile_card.dart';
import 'package:project7/widgets/custom_icons_icons.dart';
import 'package:project7/widgets/texts/profile_title.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>()..getProfile(token: GetIt.I.get<AuthLayer>().auth!.token);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(CustomIcons.edit, color: Color(0xff4D2EB4))
              )
            ],
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if(state is ShowProfileState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileCard(cubit: cubit,profile: state.profile),
                      const Padding(padding: EdgeInsets.all(20), child: Divider()),
                      const ProfileTitle(title: "Links"),
                      const SizedBox(height: 22),
                      const AccountCard(icon: Icon(Icons.description_outlined, size: 40),title: "Resume"),
                      const AccountCard(icon: Icon(CustomIcons.linkedin_in, size: 40),title: "LinkedIn"),
                      const AccountCard(icon: Icon(CustomIcons.github, size: 40),title: "Github"),
                      const AccountCard(title: "Bindlink")
                    ],
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      }),
    );
  }
}