import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/screens/my_projects/my_projects_screen.dart';
import 'package:project7/screens/navigation/cubit/page_cubit.dart';
import 'package:project7/screens/profile/profile_screen.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PageCubit()),
        BlocProvider(create: (context) => HomeCubit()..getAllProjects()), // Initialize HomeCubit
        BlocProvider(create: (context) => MyProjectsCubit()..getMyProjects()),
        BlocProvider(create: (context) => SharedCubit()..getProfile(GetIt.I.get<AuthLayer>().auth?.token)), // Initialize ProfileCubit
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
                  BlocBuilder<MyProjectsCubit, MyProjectsState>(
                    builder: (context, myProjectsState) {
                      return const MyProjectsScreen();
                    },
                  ),
                  BlocBuilder<SharedCubit, SharedState>(
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
                      label: "Home",
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                        color: cubit.currentScreen == 0
                          ? AppConstants.mainPurple
                          : Colors.black,
                      )
                    ),
                    NavigationDestination(
                      label: "My Projects",
                      icon: Icon(
                        Icons.library_books_outlined,
                        size: 30,
                        color: cubit.currentScreen == 1
                          ? AppConstants.mainPurple
                          : Colors.black,
                      ),
                    ),
                    NavigationDestination(
                      label: "Profile",
                      icon: Icon(
                        Icons.person_2_outlined,
                        size: 30,
                        color: cubit.currentScreen == 2
                          ? AppConstants.mainPurple
                          : Colors.black,
                      )
                    ),
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