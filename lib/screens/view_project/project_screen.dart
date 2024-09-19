import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/view_project_images.dart';
import 'package:project7/screens/view_project/view_project_links.dart';
import 'package:project7/screens/view_project/view_project_member.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/screens/view_project/view_rating_project.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.cubit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Container(
                        width: 111.82,
                        height: 111.82,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: .5,
                            color: const Color(0xff4f27b3)
                          )
                        ),
                        child: ClipOval(child: Image.asset('assets/images/tuwaiq_logo1.png')),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            project.projectName,
                            style: const TextStyle(
                              color: AppConstants.mainPurple,
                              fontSize: 24,
                              fontWeight: FontWeight.w700
                            )
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                              color: AppConstants.iconsGrayColor,
                            )
                          )
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(3, (index){
                          List titles = [project.bootcampName, project.type, "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}"];
                          List colors = [0xffff8c2c, 0xff01e6d5, 0xff4f27b3];
                          List icons = [Icons.lightbulb, Icons.code, Icons.calendar_month_rounded];
                          return ProjectIcon(
                            title: titles[index],
                            isVertical: true,
                            icon: Icon(icons[index], color:Color(colors[index]),size: 18)
                          );
                        })
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const ViewProjectTitle(title: 'Description'),
                Text(
                  project.projectDescription,
                  style: const TextStyle(
                    fontFamily: "Lato",
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4e4e4e)
                  )
                ),
                const ViewProjectTitle(title: "Presentation"),
                const ProjectIcon(
                  title: "Press to display presentation",
                  isVertical: false,
                  icon: Icon(
                    Icons.screenshot_monitor_outlined,
                    color: Color(0xffff8c2c),
                    size: 18,
                  ),
                ),
                const SizedBox(height: 12),
                ProjectIcon(
                  title: project.endDate,
                  isVertical: false,
                  icon: const Icon(
                    Icons.calendar_month_rounded,
                    color: Color(0xff4f27b3),
                    size: 18,
                  ),
                ),
                const ViewProjectTitle(title: "Images"),
                ViewProjectImages(images: project.imagesProject, cubit: cubit),
                const ViewProjectTitle(title: 'Members'),
                project.membersProject.isEmpty ? const Text('No Members Added')
                : Column(
                  children: List.generate(project.membersProject.length, (index) {
                    return ViewProjectMember(
                      member: project.membersProject[index],
                      teamLeadId: project.userId,
                      cubit: cubit
                    );
                  }),
                ),
                const ViewProjectTitle(title: 'Rating'),
                ListTile(
                  onTap: () => context.push(screen: ViewRatingProject(project: project,cubit: cubit,)),
                  tileColor: Colors.white,
                  shape: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(5)),
                  leading: const Icon(Icons.stacked_bar_chart_outlined,color: Colors.green),
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
                project.linksProject.isEmpty ? const Text("No Links Added") :
                ViewProjectLinks(links: project.linksProject),
                const ViewProjectTitle(title: 'Settings'),
                // settings here
              ],
            ),
          )
        )
      )
    );
  }
}