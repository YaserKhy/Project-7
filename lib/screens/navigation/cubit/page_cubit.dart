import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/my_projects/my_projects_screen.dart';
import 'package:project7/screens/profile/profile_screen.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  int currentScreen = 0;
  List<Widget> screens = [
    BlocProvider(create: (_) => HomeCubit(), child: const HomeScreen()),
    BlocProvider(create: (_) => HomeCubit(), child: const MyProjectsScreen()),
    BlocProvider(create: (_) => SharedCubit(), child: const ProfileScreen()),
  ];

  PageCubit() : super(PageInitial());

  switchTo(int targetPage) {
    currentScreen = targetPage;
    emit(SwitchScreenState());
  }
}
