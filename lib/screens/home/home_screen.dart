import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart' as home_cubit;
import 'package:project7/screens/home/view_all_projects_screen.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';
import 'package:project7/widgets/cards/project_card.dart';
import 'package:project7/widgets/tuwaiq_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    final cubit = context.read<home_cubit.HomeCubit>();
    final myProjectsCubit = context.read<MyProjectsCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          TuwaiqAppBar(page: 'home', homeCubit: cubit, myProjectsCubit: myProjectsCubit),
          BlocBuilder<home_cubit.HomeCubit, home_cubit.HomeState>(
            builder: (context, state) {
              if (state is home_cubit.LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is home_cubit.ErrorState) {
                return Center(child: Text(state.msg));
              }
              if (state is home_cubit.ShowProjectsState) {
                if (state.projects.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: context.getHeight(divideBy: 7)),
                        const Text(
                          "No Projects Found.",
                          style: TextStyle(fontFamily: 'Lato',fontSize: 16,fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  );
                }
                if (state.projects.isNotEmpty) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(cubit.getGroupedProjects(state.projects).length,(index) {
                          String bootcamp = cubit.getGroupedProjects(state.projects).keys.toList()[index];
                          List<ProjectModel> bootcampProjects = cubit.getGroupedProjects(state.projects).values.toList()[index];
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
                                      style: const TextStyle(fontSize: 20,fontFamily: 'Lato',fontWeight: FontWeight.w700,),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context.push(
                                          screen: ViewAllProjectsScreen(
                                            bootcampName: bootcamp,
                                            projects: bootcampProjects,
                                            cubit: cubit,
                                            myProjectsCubit: myProjectsCubit,
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                          Text("view all"),
                                          SizedBox(width: 10),
                                          Icon(Icons.arrow_forward_ios_outlined,size: 16,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(bootcampProjects.length, (index) {
                                      return Row(
                                        children: [
                                          ProjectCard(
                                            project: bootcampProjects[index],
                                            onTap: ()=>context.push(
                                              screen: ProjectScreen(
                                                homeCubit: cubit,
                                                myProjectsCubit: myProjectsCubit,
                                                project: bootcampProjects[index],
                                              ),
                                              updateInfo: (p0) async {
                                                if(p0!=null) {
                                                  await shared.getProfile(GetIt.I.get<AuthLayer>().auth!.token);
                                                  await cubit.refreshHome();
                                                  await myProjectsCubit.getMyProjects();
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 20,),
                                        ],
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