import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class ProjectCard extends StatelessWidget {
  final HomeCubit cubit;
  final ProjectModel project;
  final bool isHome;
  final Function()? onTap;
  const ProjectCard({super.key, required this.project, required this.cubit, this.isHome=true, this.onTap});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();

    return InkWell(
      onTap: onTap,
      child: Badge(
        isLabelVisible:
          isHome==false
          && shared.isUser()==false
          && GetIt.I.get<AuthLayer>().currentUser!.id == project.adminId ? true : false,
        label: const Text("Supervised by me", style: TextStyle(fontFamily: "Lato", color: AppConstants.mainPurple),),
        alignment: const Alignment(.4, .65),
        backgroundColor: Colors.transparent,
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
              Center(child: shared.handleLogo(logoUrl: project.logoUrl, context: context)),
              const SizedBox(height: 5),
              Text(
                project.projectName,
                maxLines: 1,
                style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 14, overflow: TextOverflow.ellipsis),
              ),
              Text(
                project.bootcampName,
                style: const TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w500, fontSize: 11, color: AppConstants.textGrayColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}