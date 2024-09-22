import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';
import 'package:project7/widgets/cards/project_card.dart';

class ViewAllProjectsScreen extends StatelessWidget {
  final String bootcampName;
  final List<ProjectModel> projects;
  final HomeCubit cubit;
  final MyProjectsCubit myProjectsCubit;
  const ViewAllProjectsScreen({super.key,required this.bootcampName,required this.projects,required this.cubit, required this.myProjectsCubit,});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$bootcampName Bootcamp Projects',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppConstants.mainPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),onPressed: ()=> context.pop()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(projects.length, (index) {
              return ProjectCard(
                project: projects[index],
                isHome: false,
                onTap: () => context.push(
                  screen: ProjectScreen(
                    project: projects[index],
                    homeCubit: cubit
                  ),
                  updateInfo: (p0) {
                    if(p0!=null) {
                      shared.getProfile(GetIt.I.get<AuthLayer>().auth!.token);
                      cubit.refreshHome();
                      myProjectsCubit.getMyProjects();
                    }
                  },
                )
              );
            })
          ),
        )
      )
    );
  }
}