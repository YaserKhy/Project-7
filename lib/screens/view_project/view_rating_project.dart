import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/widgets/buttons/edit_button.dart';
import 'package:project7/widgets/cards/rating_field.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ViewRatingProject extends StatelessWidget {
  final ProjectModel project;
  final ViewProjectCubit cubit;
  final Function()? onSave;
  const ViewRatingProject(
      {super.key, required this.project, required this.cubit, this.onSave});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => ViewProjectCubit(),
        child: Scaffold(
            backgroundColor: AppConstants.bgColor,
            appBar: AppBar(backgroundColor: AppConstants.bgColor),
            body: SafeArea(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: shared
                                            .handleProfilePage(
                                                logoUrl: project.logoUrl,
                                                context: context)
                                            .image),
                                    const SizedBox(height: 9),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(project.projectName,
                                            style: const TextStyle(
                                                color: AppConstants.mainPurple,
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    const SizedBox(height: 7),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: List.generate(3, (index) {
                                          List titles = [
                                            project.bootcampName,
                                            project.type,
                                            "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}"
                                          ];
                                          List colors = [
                                            0xffff8c2c,
                                            0xff01e6d5,
                                            0xff4f27b3
                                          ];
                                          List icons = [
                                            Icons.lightbulb,
                                            Icons.code,
                                            Icons.calendar_month_rounded
                                          ];
                                          return ProjectIcon(
                                              title: titles[index],
                                              isVertical: true,
                                              icon: Icon(icons[index],
                                                  color: Color(colors[index]),
                                                  size: 18));
                                        })),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              ViewProjectTitle(
                                  project: project,
                                  title: 'Rating',
                                  editable: false),
                              Text(
                                "Support ${project.projectName} and give them your feedback on scale 1 to 10 how do you rate ",
                                style: const TextStyle(
                                    color: AppConstants.textGrayColor,
                                    fontSize: 15),
                              ),
                              const SizedBox(height: 20),
                              const RatingField(
                                  title: 'Idea',
                                  iconToAdd: Icon(
                                    Icons.lightbulb,
                                    color: AppConstants.orange,
                                  )),
                              const SizedBox(height: 20),
                              const RatingField(
                                  title: "Design",
                                  iconToAdd: Icon(
                                    Icons.color_lens_outlined,
                                    color: Color(0xffF565BB),
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const RatingField(
                                  title: "Tools",
                                  iconToAdd: Icon(
                                    Icons.keyboard_command_key_sharp,
                                    color: AppConstants.brownIcon,
                                  )),
                              const SizedBox(
                                height: 20,
                              ),
                              const RatingField(
                                  title: "Practices",
                                  iconToAdd: Icon(
                                    Icons.shape_line_outlined,
                                    color: AppConstants.blue,
                                  )),
                              const SizedBox(height: 20),
                              const RatingField(
                                  title: "Presentation",
                                  iconToAdd: Icon(
                                    Icons.screenshot_monitor_outlined,
                                    color: Color(0xffff8c2c),
                                  )),
                              const SizedBox(height: 20),
                              const RatingField(
                                  title: "Investment",
                                  iconToAdd: Icon(
                                    Icons.attach_money_sharp,
                                    color: Colors.green,
                                  )),
                              const SizedBox(height: 30),
                              const Text("Note"),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      width: 353,
                                      height: 115,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color(0xffd9d9d9)),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextField(
                                        controller: cubit.commentController,
                                        maxLines:
                                            null, // Expands vertically as needed
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              EditButton(
                                buttonText: "Save",
                                onSave: onSave,
                                onCancel: () => context.pop(),
                              )
                            ]))))),
      ),
    );
  }
}
