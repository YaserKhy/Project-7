import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/edit_project/edit_base_info.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/view_project_images.dart';
import 'package:project7/screens/view_project/view_project_member.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/screens/view_project/view_rating_project.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.bgColor,
        appBar: AppBar(
          backgroundColor: AppConstants.bgColor,
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
        ),
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
                    Container(
                      width: 111.82,
                      height: 111.82,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: .5, color: const Color(0xff4f27b3))),
                      child: ClipOval(
                          child: Image.asset('assets/images/tuwaiq_logo1.png')),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(project.projectName,
                            style: const TextStyle(
                                color: AppConstants.mainPurple,
                                fontSize: 24,
                                fontWeight: FontWeight.w700)),
                        // const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              context.push(screen: const EditBaseInfo());
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                              color: AppConstants.iconsGrayColor,
                            ))
                        // const Icon(Icons.edit, size: 15),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ProjectIcon(
                            icon: const Icon(
                              Icons.lightbulb,
                              color: Color(0xffff8c2c),
                              size: 18,
                            ),
                            title: project.bootcampName,
                            isVertical: true),
                        ProjectIcon(
                            icon: const Icon(
                              Icons.code,
                              color: Color(0xff01e6d5),
                              size: 18,
                            ),
                            title: project.type,
                            isVertical: true),
                        ProjectIcon(
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xff4f27b3),
                              size: 18,
                            ),
                            title:
                                "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}",
                            isVertical: true),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const ViewProjectTitle(title: 'Description'),
              Text(project.projectDescription,
                  style: const TextStyle(
                      fontFamily: "Lato",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4e4e4e))),
              const ViewProjectTitle(title: "Presentation"),
              const ProjectIcon(
                  title: "Press to display presentation",
                  icon: Icon(
                    Icons.screenshot_monitor_outlined,
                    color: Color(0xffff8c2c),
                    size: 18,
                  ),
                  isVertical: false),
              const SizedBox(
                height: 12,
              ),
              ProjectIcon(
                  title: project.endDate,
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xff4f27b3),
                    size: 18,
                  ),
                  isVertical: false),
              const ViewProjectTitle(title: "Images"),
              ViewProjectImages(images: project.imagesProject, cubit: cubit),
              const ViewProjectTitle(title: 'Members'),
              project.membersProject.isEmpty
                  ? const Text('No Members Added')
                  : Column(
                      children:
                          List.generate(project.membersProject.length, (index) {
                        return ViewProjectMember(
                            member: project.membersProject[index],
                            teamLeadId: project.userId,
                            cubit: cubit);
                      }),
                    ),
              const ViewProjectTitle(title: 'Rating'),
              ListTile(
                onTap: () => context.push(
                    screen: ViewRatingProject(
                  project: project,
                )),
                tileColor: Colors.white,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                leading: const Icon(Icons.stacked_bar_chart_outlined,
                    color: Colors.green),
                title: Text(
                  "Rate ${project.projectName}",
                  style: const TextStyle(color: AppConstants.textGrayColor),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppConstants.iconsGrayColor,
                ),
              ),
              const ViewProjectTitle(title: 'Links'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: AppConstants.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.video_collection_rounded,
                          color: AppConstants.iconsGrayColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Video",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppConstants.textGrayColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: AppConstants.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    // padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/figma.png",
                          height: 25,
                        ),
                        const Text(
                          "Figma",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppConstants.textGrayColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 113,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1.5, color: AppConstants.blue),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: const Row(
                      children: [
                        Icon(
                          CustomIcons.github,
                          color: AppConstants.iconsGrayColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "GitHup",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppConstants.textGrayColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              )
              // links here
              ,
              const ViewProjectTitle(title: 'Settings'),
              // settings here
            ],
          ),
        ))));
  }
}
