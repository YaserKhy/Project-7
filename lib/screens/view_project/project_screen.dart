import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/view_project_images.dart';
import 'package:project7/screens/view_project/view_project_member.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      appBar: AppBar(backgroundColor: AppConstants.bgColor, actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.edit))],),
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
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(width: .5,color: const Color(0xff4f27b3))),
                        child: ClipOval(child: Image.asset('assets/images/tuwaiq_logo1.png')),
                      ),
                      const SizedBox(height: 9,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(project.projectName, style: const TextStyle(color: AppConstants.mainPurple, fontSize: 24, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 10),
                          const Icon(Icons.edit, size: 15),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProjectIcon(icon: const Icon(Icons.lightbulb, color: Color(0xffff8c2c),size: 18,), title: project.bootcampName, isVertical: true),
                          ProjectIcon(icon: const Icon(Icons.code, color: Color(0xff01e6d5),size: 18,), title: project.type, isVertical: true),
                          ProjectIcon(icon: const Icon(Icons.calendar_month_rounded, color: Color(0xff4f27b3),size: 18,), title: "${project.endDate.substring(2,4)}/${project.endDate.substring(5,7)}", isVertical: true),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                const ViewProjectTitle(title: 'Description'),
                Text(project.projectDescription, style: const TextStyle(fontFamily: "Lato", fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff4e4e4e))),
                const ViewProjectTitle(title: "Presentation"),
                const ProjectIcon(title: "Press to display presentation", icon: Icon(Icons.screenshot_monitor_outlined, color: Color(0xffff8c2c), size: 18,), isVertical: false),
                const SizedBox(height: 12,),
                ProjectIcon(title: project.endDate, icon: const Icon(Icons.screenshot_monitor_outlined, color: Color(0xff4f27b3), size: 18,), isVertical: false),
                const ViewProjectTitle(title: "Images"),
                ViewProjectImages(images: project.imagesProject, cubit: cubit),
                const ViewProjectTitle(title: 'Members'),
                Column(
                  children: List.generate(project.membersProject.length, (index){
                    return ViewProjectMember(member: project.membersProject[index], teamLeadId: project.userId, cubit: cubit);
                  }),
                ),
                const ViewProjectTitle(title: 'Rating'),
                ListTile(
                  tileColor: Colors.white,
                  shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
                  leading: const Icon(Icons.stacked_bar_chart_outlined),
                  title: Text("Rate ${project.projectName}"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                ),
                const ViewProjectTitle(title: 'Links'),
                // links here
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