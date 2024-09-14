import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/screens/profile/profile_screen.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  int currentScreen = 0;
  List<Widget> screens = [
    BlocProvider(create: (_) => HomeCubit(), child: HomeScreen()),
    const Placeholder(),
    BlocProvider(create: (_) => ProfileCubit(), child: ProfileScreen()),
  ];

  PageCubit() : super(PageInitial());

  switchTo(int targetPage) {
    currentScreen = targetPage;
    emit(SwitchScreenState());
  }

  double getIconSize(int index) {
    return currentScreen == index ? 40 : 25;
  }
}
