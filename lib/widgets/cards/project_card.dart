import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';

class ProjectCard extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectCard({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> context.push(screen: ProjectScreen(project: project, cubit: cubit,)),
      child: Container(
        width: 150,
        height: 170,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: .3, color: AppConstants.mainPurple),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: cubit.handleLogo(logoUrl: project.logoUrl, context: context, height: 66)
            ),
            const SizedBox(height: 5),
            Text(
              project.projectName,
              maxLines: 2,
              style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 14, overflow: TextOverflow.fade),
            ),
            Text(
              project.bootcampName,
              style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 11, color: Color(0xff868686)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  project.endDate,
                  style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 10, color: Colors.black),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(project.rating.toString(), style: const TextStyle(fontFamily: "Lato", fontSize: 10, fontWeight: FontWeight.w500),),
                    const Icon(Icons.star_border_outlined, color: Colors.yellow, size: 15,)
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}