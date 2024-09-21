import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';
import 'package:project7/widgets/cards/project_card.dart';

class ViewAllProjectsScreen extends StatelessWidget {
  final String bootcampName;
  final List<ProjectModel> projects;
  final HomeCubit cubit;

  const ViewAllProjectsScreen({
    super.key,
    required this.bootcampName,
    required this.projects,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All $bootcampName Projects',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppConstants.mainPurple,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: projects.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.getHeight(divideBy: 7)),
                  const Text(
                    "No Projects Found.",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(
                    project: projects[index],
                    cubit: cubit,
                    onTap: () => context.push(
                      screen: ProjectScreen(project: projects[index], cubit: cubit),
                      updateInfo: (p0) {
                        if(p0!=null) {
                          cubit.refreshHome();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}