import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';
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
        BlocProvider(
          create: (context) => PageCubit(),
        ),
        BlocProvider(
          create: (context) =>
              HomeCubit()..getAllProjects(), 
        ),
        BlocProvider(
          create: (context) =>
              AddProjectBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final cubit = context.read<PageCubit>();
        return BlocBuilder<PageCubit, PageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/images/tuwaiq_logo2.png',
                    height: 85, width: 197),
                centerTitle: true,
              ),
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
                      return const AddProjectScreen();
                    },
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profileState) {
                      return const ProfileScreen();
                    },
                  ),
                ],
              ),
              bottomNavigationBar: CurvedNavigationBar(
                height: context.getHeight(divideBy: 15),
                color: AppConstants.mainPurple,
                backgroundColor: Colors.white,
                buttonBackgroundColor: AppConstants.mainPurple,
                onTap: (value) => cubit.switchTo(value),
                items: [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: cubit.getIconSize(0),
                  ),
                  Icon(Icons.add,
                      color: Colors.white, size: cubit.getIconSize(1)),
                  Icon(Icons.person_2_outlined,
                      color: Colors.white, size: cubit.getIconSize(2)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
