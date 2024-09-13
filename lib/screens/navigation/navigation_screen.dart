import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/navigation/cubit/page_cubit.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<PageCubit>();
        return BlocBuilder<PageCubit, PageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/images/tuwaiq_logo2.png', height: 85, width: 197),
                centerTitle: true,
              ),
              body: cubit.screens[cubit.currentScreen],
              bottomNavigationBar: CurvedNavigationBar(
                height: context.getHeight(divideBy: 15),
                color: Color(0xff4D2EB4),
                backgroundColor: Colors.white,
                buttonBackgroundColor: Color(0xff4D2EB4),
                onTap: (value) => cubit.switchTo(value),
                items: [
                  Icon(Icons.home_outlined, color: Colors.white, size: cubit.getIconSize(0),),
                  Icon(Icons.add, color: Colors.white, size:  cubit.getIconSize(1)),
                  Icon(Icons.person_2_outlined, color: Colors.white, size: cubit.getIconSize(2))
                ],
              ),
            );
          },
        );
      }),
    );
  }
}