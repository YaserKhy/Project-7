import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:project7/screens/home/home_screen.dart';
import 'package:project7/screens/profile/profile_screen.dart';

part 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageInitial());
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const Placeholder(),
    const ProfileScreen()
  ];

  switchTo(int targetPage) {
    currentScreen = targetPage;
    emit(SwitchScreenState());
  }

  double getIconSize(int index) {
    return currentScreen == index ? 40 : 25;
  }
}
