import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/project_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final ProfileModel user = GetIt.I.get<AuthLayer>().currentUser!;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
          children: [
            // home app bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: context.getWidth(),
              height: 190,
              decoration: const BoxDecoration(
                color: AppConstants.mainPurple,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)
                )
              ),
              child: Column(
                children: [
                  const SizedBox(height: 38),
                  ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: ClipOval(child: Image.asset('assets/images/tuwaiq_logo1.png')),
                    ),
                    title: const Text("Welcome"),
                    titleTextStyle: const TextStyle(
                      inherit: false,
                      fontFamily: "Lato",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffdadada)
                    ),
                    subtitle: Text('${user.firstName} ${user.lastName}  👋'),
                    subtitleTextStyle: const TextStyle(
                      inherit: false,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      fontFamily: "Lato",
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: context.getWidth(divideBy: 1.2),
                        height: 30,
                        child: TextFormField(
                          controller: cubit.searchController,
                          onChanged: (value) => cubit.handleSearch(value),
                          cursorHeight: 17,
                          style: const TextStyle(fontSize: 13),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search for a project ....",
                            hintStyle: TextStyle(color: Colors.black45, fontSize: 13),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppConstants.mainPurple, width: 1.5),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      const Icon(Icons.qr_code, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
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