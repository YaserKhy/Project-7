import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/screens/login/login_screen.dart';

import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/screens/profile/edit_profile_screen.dart';
import 'package:project7/widgets/buttons/profile_button.dart';
import 'package:project7/widgets/cards/account_card.dart';

import 'package:project7/widgets/cards/profile_card.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    cubit.getProfile(token: GetIt.I.get<AuthLayer>().auth!.token);

    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ErrorState) {
            return Center(child: Text(state.msg));
          }
          if (state is ShowProfileState) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)),
                      child: IconButton(
                          onPressed: () {
                            context.push(
                                screen: EditProfileScreen(
                                    profile: state.profile, cubit: cubit));
                          },
                          icon: const Icon(CustomIcons.edit,
                              color: AppConstants.mainPurple)),
                    ),
                  ),
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
                  const SizedBox(height: 60),
                  Container(
                    width: context.getWidth(divideBy: 1.1),
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 9),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        AccountCard(
                          icon: Icons.description_outlined,
                          title: "Resume",
                          urlPath: state.profile.link?.resume,
                        ),
                        AccountCard(
                            icon: CustomIcons.linkedin_in,
                            title: "LinkedIn",
                            urlPath:
                                "https://www.linkedin.com/in/${state.profile.link?.linkedin}"),
                        AccountCard(
                            icon: CustomIcons.github,
                            title: "Github",
                            urlPath:
                                "https://github.com/${state.profile.link?.github}"),
                        AccountCard(
                            icon: Icons.link,
                            title: "Bindlink",
                            urlPath:
                                "https://bind.link/@${state.profile.link?.bindlink}"),
                        ProfileButton(
                          icon: Icons.power_settings_new,
                          color: const Color(0xffFF4B4B),
                          title: "Logout",
                          onPressed: () async {
                            log('user was ${GetIt.I.get<AuthLayer>().auth?.token.substring(1, 10)}');
                            await cubit.logOut();
                            log('user is ${GetIt.I.get<AuthLayer>().auth?.token}');
                            context.pushRemove(screen: const LoginScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
