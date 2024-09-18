import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart' as home_cubit;
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/widgets/cards/project_card.dart';
import 'package:project7/widgets/tuwaiq_app_bar.dart';

class MyProjectsScreen extends StatelessWidget {
  const MyProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<home_cubit.HomeCubit>();
    final cubit = context.read<MyProjectsCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          TuwaiqAppBar(page:'My Projects', cubit: cubit),
          BlocBuilder<MyProjectsCubit, MyProjectsState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ErrorState) {
                return Center(child: Text(state.msg));
              }
              if (state is ShowMyProjectsState) {
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
                                    const Row(
                                      children: [
                                        Text("view all"),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                                SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(bootcampProjects.length, (index){
                                      return ProjectCard(project: bootcampProjects[index], cubit: homeCubit, isHome:false);
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