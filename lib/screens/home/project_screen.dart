import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/widgets/cards/team_member.dart';
import 'package:project7/widgets/custom_icons_icons.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: AppConstants.mainPurple, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: AppConstants.mainPurple,
                              offset: Offset(2, 4))
                        ]),
                    alignment: Alignment.center,
                    child: cubit.handleLogo(
                        logoUrl: project.logoUrl,
                        context: context,
                        heightDivide: 5,
                        widthDivide: 2),
                  ),
                ),
                const SizedBox(height: 41),
                Text(project.projectName,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Text(project.projectDescription,
                    style: const TextStyle(
                        fontFamily: "Lato",
                        fontSize: 12,
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 20),
                const Text("Presentation",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Text(project.presentationUrl),
                const SizedBox(height: 20),
                const Text("Images",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                const SizedBox(height: 20),
                SizedBox(
                  height: context.getHeight(divideBy: 5),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        List.generate(project.imagesProject.length, (index) {
                      return cubit.handleLogo(
                          logoUrl: project.imagesProject[index].url,
                          context: context,
                          heightDivide: 10,
                          widthDivide: 3);
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Rating",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: AppConstants.mainPurple,
                            offset: Offset(2, 4))
                      ],
                      border: Border.all(
                          width: 1.5, color: AppConstants.mainPurple),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 64,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocBuilder<HomeCubit, HomeState>(
                              bloc: cubit,
                              builder: (context, state) {
                                return Container(
                                  width: context.getWidth(),
                                  height: context.getHeight(divideBy: 5),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Design",
                                          style: TextStyle(
                                              color: AppConstants.mainPurple,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 28)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      RatingStars(
                                        value: cubit.currentStars,
                                        onValueChanged: (value) =>
                                            cubit.changeStars(value),
                                        starCount: 10,
                                        starSize: 35,
                                        valueLabelVisibility: false,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rate ${project.projectName}",
                          style: const TextStyle(
                              fontFamily: "Lato",
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        const Icon(Icons.arrow_forward_ios_outlined, size: 20)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Group member",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                const MemberCard(
                    name: "Sara",
                    role: "Team lead",
                    boxColor: AppConstants.orange,
                    shadowColor: AppConstants.orange),
                const SizedBox(
                  height: 15,
                ),
                const MemberCard(
                  name: "Ahmed",
                  role: "Team member",
                  boxColor: AppConstants.teamMember1,
                  shadowColor: AppConstants.teamMember1,
                ),
                const SizedBox(height: 20),
                const Text("Links",
                    style: TextStyle(
                        color: AppConstants.mainPurple,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 20)),
                const Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: AppConstants.mainPurple,
                                    offset: Offset(2, 4))
                              ],
                              border: Border.all(
                                  width: 1.5, color: AppConstants.mainPurple),
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: 120,
                          child: const Row(
                            children: [
                              Icon(Icons.video_collection_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Video",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: AppConstants.mainPurple,
                                    offset: Offset(2, 4))
                              ],
                              border: Border.all(
                                  width: 1.5, color: AppConstants.mainPurple),
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: 120,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/figma.png",
                                height: 30,
                                width: 40,
                              ),
                              Text(
                                "Figma",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: AppConstants.mainPurple,
                                    offset: Offset(2, 4))
                              ],
                              border: Border.all(
                                  width: 1.5, color: AppConstants.mainPurple),
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 50,
                          width: 120,
                          child: const Row(
                            children: [
                              Icon(CustomIcons.github),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "GitHub",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          )),
                    ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppConstants.lightBlue),
                        child: Icon(
                          Icons.edit,
                          color: AppConstants.blue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
