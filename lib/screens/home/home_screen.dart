import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/project_card.dart';
import 'package:project7/widgets/tuwaiq_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
          children: [
            TuwaiqAppBar(page: 'home',cubit: cubit),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ErrorState) {
                  return Center(child: Text(state.msg));
                }
                if (state is ShowProjectsState) {
                  if (state.projects.isEmpty) {
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
                  if(state.projects.isNotEmpty) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            cubit.getGroupedProjects(state.projects).length,
                            (index){
                              String bootcamp = cubit.getGroupedProjects(state.projects).keys.toList()[index];
                              List<ProjectModel> bootcampProjects = cubit.getGroupedProjects(state.projects).values.toList()[index];
                              return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: List.generate(bootcampProjects.length, (index){
                                        return Row(
                                          children: [
                                            ProjectCard(project: bootcampProjects[index], cubit: cubit),
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