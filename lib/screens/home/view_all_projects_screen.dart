import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';
import 'package:project7/widgets/cards/project_card.dart';

class ViewAllProjectsScreen extends StatelessWidget {
  final String bootcampName;
  final List<ProjectModel> projects;
  final HomeCubit cubit;

  const ViewAllProjectsScreen({super.key,required this.bootcampName,required this.projects,required this.cubit,});

  @override
  Widget build(BuildContext context) {
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
                  )
                )
              );
            })
          ),
        )
      )
    );
  }
}