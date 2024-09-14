import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/navigation/cubit/page_cubit.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/screens/profile/profile_screen.dart';

// class NavigationScreen extends StatelessWidget {
//   const NavigationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => PageCubit(),
//       child: Builder(builder: (context) {
//         final cubit = context.read<PageCubit>();
//         return BlocBuilder<PageCubit, PageState>(
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Image.asset('assets/images/tuwaiq_logo2.png',
//                     height: 85, width: 197),
//                 centerTitle: true,
//               ),
//               body: cubit.screens[cubit.currentScreen],
//               bottomNavigationBar: CurvedNavigationBar(
//                 height: context.getHeight(divideBy: 15),
//                 color: AppConstants.mainPurple,
//                 backgroundColor: Colors.white,
//                 buttonBackgroundColor: AppConstants.mainPurple,
//                 onTap: (value) => cubit.switchTo(value),
//                 items: [
//                   Icon(
//                     Icons.home_outlined,
//                     color: Colors.white,
//                     size: cubit.getIconSize(0),
//                   ),
//                   Icon(Icons.add,
//                       color: Colors.white, size: cubit.getIconSize(1)),
//                   Icon(Icons.person_2_outlined,
//                       color: Colors.white, size: cubit.getIconSize(2))
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }


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
          create: (context) => HomeCubit()..getAllProjects(), // Initialize HomeCubit
        ),
        BlocProvider(
          create: (context) => ProfileCubit(), // Initialize ProfileCubit
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
                      return const HomeScreen(); // Wrap HomeScreen
                    },
                  ),
                  const Placeholder(),
                   // Your Add screen here
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profileState) {
                      return const ProfileScreen(); // Wrap ProfileScreen
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
