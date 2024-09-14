import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/project_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllProjects(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        width: context.getWidth() / 1.2,
                        height: 46,
                        child: TextFormField(
                          controller: cubit.searchController,
                          onChanged: (value) => cubit.handleSearch(value),
                          decoration: const InputDecoration(
                            hintText: "Search for a project ....",
                            hintStyle: TextStyle(color: Colors.black45),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppConstants.mainPurple, width: .5),
                              borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                          ),
                        )
                      ),
                      const Icon(Icons.filter_alt,color: AppConstants.mainPurple)
                    ],
                  ),
                  const SizedBox(height: 44),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if(state is ShowProjectsState) {
                        if(state.projects.isEmpty) {
                          return const Center(child: Text("No Projects Found.", style: TextStyle(fontFamily: 'Lato', fontSize: 16, fontWeight: FontWeight.w700),),);
                        }
                        List<String> boots = [];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GroupedListView(
                              elements: state.projects,
                              groupBy: (e) => e.bootcampName,
                              // header
                              groupSeparatorBuilder: (value) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(value,style: const TextStyle(fontFamily: 'Lato',  fontSize: 20,  fontWeight: FontWeight.w700),),
                                        const Row(
                                          children: [
                                            Text("view all"),
                                            SizedBox(width: 10),
                                            Icon(Icons.arrow_forward_ios_outlined,size: 16),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                              // content, gridview under each bootcamp
                              itemBuilder: (context, element) {
                                if(boots.contains(element.bootcampName)) {
                                  return const SizedBox.shrink();
                                }
                                boots.add(element.bootcampName);
                                return Column(
                                children: [
                                  GridView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                    children: List.generate(
                                      cubit.getBootcampProjects(element.bootcampName).length, (index) {
                                        return ProjectCard(project: cubit.getBootcampProjects(element.bootcampName)[index], cubit: cubit);
                                      }
                                    ),
                                  )
                                ],
                              );
                              }
                            ),
                          ),
                        );
                      }
                      return const Center(child:CircularProgressIndicator());
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ),
        );
      }),
    );
  }
}