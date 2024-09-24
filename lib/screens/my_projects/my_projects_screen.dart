import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart' as my_cubit;
import 'package:project7/screens/view_project/project_screen.dart';
import 'package:project7/widgets/cards/project_card.dart';
import 'package:project7/widgets/tuwaiq_app_bar.dart';

class MyProjectsScreen extends StatelessWidget {
  const MyProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final cubit = context.read<my_cubit.MyProjectsCubit>();
    final shared = context.read<SharedCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          TuwaiqAppBar(
            page:'My Projects',
            homeCubit: homeCubit,
            myProjectsCubit: cubit,
            onAdd: ()=> context.push(
              screen: const AddProjectScreen(),
              updateInfo: (p0) async {
                if(p0!=null) {
                  await shared.getProfile(GetIt.I.get<AuthLayer>().auth!.token);
                  await homeCubit.refreshHome();
                  await cubit.getMyProjects();
                }
              },
            ),
          ),
          BlocBuilder<my_cubit.MyProjectsCubit, my_cubit.MyProjectsState>(
            builder: (context, state) {
              if (state is my_cubit.LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is my_cubit.ErrorState) {
                return Center(child: Text(state.msg));
              }
              if (state is my_cubit.ShowMyProjectsState) {
                if (state.myProjects.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: context.getHeight(divideBy: 7)),
                        const Text(
                          "No Projects Found.",
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  );
                }
                if(state.myProjects.isNotEmpty) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(cubit.getGroupedProjects(state.myProjects).length, (index){
                          String bootcamp = cubit.getGroupedProjects(state.myProjects).keys.toList()[index];
                          List<ProjectModel> bootcampProjects = cubit.getGroupedProjects(state.myProjects).values.toList()[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bootcamp,
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(bootcampProjects.length, (index){
                                      ProjectModel project = bootcampProjects[index];
                                      log("${project.projectName} ${project.logoUrl}");
                                      return ProjectCard(
                                        project: bootcampProjects[index],
                                        isHome:false,
                                        onTap: ()=> context.push(
                                          screen: ProjectScreen(
                                            myProjectsCubit: cubit,
                                            project: bootcampProjects[index],
                                            homeCubit: homeCubit
                                          ),
                                          updateInfo: (p0) async {
                                            if(p0!=null) {
                                              await shared.getProfile(GetIt.I.get<AuthLayer>().auth!.token);
                                              await homeCubit.refreshHome();
                                              await cubit.getMyProjects();
                                            }
                                          },
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }
              }
              return const Text("data");
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}