import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/screens/profile/edit_profile_screen.dart';
import 'package:project7/widgets/buttons/profile_button.dart';
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
        final cubit = context.read<ProfileCubit>()
          ..getProfile(token: GetIt.I.get<AuthLayer>().auth!.token);
        return Scaffold(
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ShowProfileState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      ProfileCard(
                        cubit: cubit,
                        profile: state.profile,
                        onEdit: () => context.push(
                            screen: EditProfileScreen(
                          profile: state.profile,
                          cubit: cubit,
                        )),
                      ),
                      const Padding(
                          padding: EdgeInsets.all(20), child: Divider()),
                      const ProfileTitle(title: "Links"),
                      const SizedBox(height: 22),
                      const AccountCard(
                          icon: Icon(Icons.description_outlined, size: 40),
                          title: "Resume"),
                      const AccountCard(
                          icon: Icon(CustomIcons.linkedin_in, size: 40),
                          title: "LinkedIn"),
                      const AccountCard(
                          icon: Icon(CustomIcons.github, size: 40),
                          title: "Github"),
                      const AccountCard(title: "Bindlink"),
                      const SizedBox(height: 10),
                      const ProfileButton(
                        title: "Logout",
                        color: Color(0xffD12D2D),
                      ),
                      const SizedBox(height: 20),
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


