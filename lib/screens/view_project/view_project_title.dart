import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/edit_project/edit_base_info.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart';

class ViewProjectTitle extends StatelessWidget {
  final String title;
  final bool editable;
  final ProjectModel project;
  const ViewProjectTitle({super.key, required this.title, this.editable=false, required this.project});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewProjectCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                color: AppConstants.mainPurple
              )
            ),
            const SizedBox(width: 5),
            editable ? InkWell(
              onTap: () async {
                if(title == 'Presentation') {
                  log('Edit Presentation');
                }
                else if(title == 'Images') {
                  final selectedImages = await ImagePicker().pickMultiImage(limit: 4);
                  if(selectedImages.isNotEmpty) {
                    List<String> imgsPaths = selectedImages.map((img)=>File(img.path).path).toList();
                    cubit.updateImages(imgs: imgsPaths, projectId: project.projectId, projectImages: project.imagesProject);
                  }
                }
                else if(title == 'Members') {
                  log('Edit Members');
                }
                else if(title == 'Links') {
                  log('Edit Links');
                }
                else {
                  context.push(screen: EditBaseInfo(project: project));
                }
              },
              child: const Icon(
                Icons.edit,
                size: 15,
                color: AppConstants.iconsGrayColor,
              )
            ) : const SizedBox.shrink()
          ],
        ),
        const Divider(),
      ],
    );
  }
}