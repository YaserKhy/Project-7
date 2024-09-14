import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class ProjectCard extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  const ProjectCard({super.key, required this.project, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: AppConstants.mainPurple),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: AppConstants.mainPurple, offset: Offset(2, 4))]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: cubit.handleLogo(logoUrl: project.logoUrl, context: context)
            ),
            const SizedBox(height: 10),
            Text(
              project.projectName,
              style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingStars(
                  value: project.rating,
                  starCount: 5,
                  starSize: 20,
                  valueLabelVisibility: false,
                ),
                Row(
                  children: [
                    const Icon(Icons.person_2_outlined,size: 20),
                    Text(project.membersProject.length.toString())
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}