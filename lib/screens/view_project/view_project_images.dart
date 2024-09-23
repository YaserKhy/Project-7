import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';

class ViewProjectImages extends StatelessWidget {
  final ProjectModel project;
  final Function(ImagesProject imgToDelete)? onDelete;
  const ViewProjectImages({super.key, required this.project, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return project.imagesProject.isEmpty ? const Text("No Images Added")
    : SizedBox(
      height: context.getHeight(divideBy: 5),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: project.imagesProject.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()=> onDelete?.call(project.imagesProject[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: shared.handleLogo(
                logoUrl: project.imagesProject[index].url,
                context: context,
                heightDivide: 1,
                widthDivide: 3
              ),
            ),
          );
        },
        separatorBuilder: (context, index)=>const SizedBox(width: 20,)
      ),
    );
  }
}