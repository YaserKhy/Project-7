import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/project_card.dart';
import 'package:project7/widgets/custom_icons_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>()..getAllProjects();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
              body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        width: context.getWidth() / 1.2,
                        height: 46,
                        child: TextFormField(
                          // controller: Text,
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff4D2EB4), width: .5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                        )),
                    const Icon(
                      CustomIcons.filter,
                      color: Color(0xff4d2eb4),
                    )
                  ],
                ),
                const SizedBox(
                  height: 44,
                ),
                // list to store all projects, groupby ['bootcamp_name']
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is ShowProjectsState) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GroupedListView(
                            elements: state.projects,
                            groupBy: (e) => e.bootcampName,
                            itemBuilder: (context, element) => Column(
                              children: [
                                GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  children: List.generate(
                                      cubit.getBootLength(element.bootcampName),
                                      (index) {
                                    return ProjectCard(project: element);
                                  }),
                                )
                              ],
                            ),
                            groupSeparatorBuilder: (value) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      value,
                                      style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        Text("view all"),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 16,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if (state is LoadingState) {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));
                    }
                    return Text("ERRROOOORRRR");
                  },
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
