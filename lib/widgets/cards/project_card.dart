import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/my_projects/cubit/my_projects_cubit.dart';
import 'package:project7/screens/view_project/project_screen.dart';

class ProjectCard extends StatelessWidget {
  final HomeCubit cubit;
  final MyProjectsCubit? my;
  final ProjectModel project;
  final bool isHome;
  const ProjectCard({super.key, required this.project, required this.cubit, this.isHome=true, this.my});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return InkWell(
      onTap: ()=> context.push(screen: ProjectScreen(project: project, cubit: cubit,)),
      child: Container(
        width: isHome ? 150 : context.getWidth(),
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
              child: shared.handleLogo(logoUrl: project.logoUrl, context: context, height: 66.0)
            ),
            const SizedBox(height: 5),
            Text(
              project.projectName,
              maxLines: 1,
              style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 14, overflow: TextOverflow.ellipsis),
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