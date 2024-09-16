import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';
import 'package:project7/screens/add_project/user_project_screen.dart';
import 'package:project7/screens/add_project/bloc/add_project_bloc.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/navigation/cubit/page_cubit.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/screens/profile/profile_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(
            create: (context) =>
                HomeCubit()..getAllProjects()), // Initialize HomeCubit
        BlocProvider(create: (context) => AddProjectBloc()),
        BlocProvider(
            create: (context) => ProfileCubit()), // Initialize ProfileCubit
      ],
      child: Builder(builder: (context) {
        final cubit = context.read<PageCubit>();
        return BlocBuilder<PageCubit, PageState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppConstants.bgColor,
              body: IndexedStack(
                index: cubit.currentScreen,
                children: [
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, homeState) {
                      return const HomeScreen();
                    },
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, homeState) {
                      return const UserProjectScreen();
                    },
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profileState) {
                      return const ProfileScreen();
                    },
                  ),
                ],
              ),
              bottomNavigationBar: Container(
                color: Colors.black,
                padding: const EdgeInsets.only(top: .3),
                child: NavigationBar(
                  selectedIndex: cubit.currentScreen,
                  onDestinationSelected: (value) => cubit.switchTo(value),
                  height: context.getHeight(divideBy: 15),
                  indicatorColor: Colors.transparent,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  overlayColor: WidgetStateColor.transparent,
                  backgroundColor: Colors.white,
                  destinations: [
                    NavigationDestination(
                        icon: Icon(
                          Icons.home_outlined,
                          size: 30,
                          color: cubit.currentScreen == 0
                              ? AppConstants.mainPurple
                              : Colors.black,
                        ),
                        label: "Home"),
                    NavigationDestination(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: cubit.currentScreen == 1
                              ? AppConstants.mainPurple
                              : Colors.black,
                        ),
                        label: "Add"),
                    NavigationDestination(
                        icon: Icon(
                          Icons.person_2_outlined,
                          size: 30,
                          color: cubit.currentScreen == 2
                              ? AppConstants.mainPurple
                              : Colors.black,
                        ),
                        label: "Profile"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
