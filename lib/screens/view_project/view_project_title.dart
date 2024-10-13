import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/helpers/file_picker.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/edit_project/edit_base_info.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart';

class ViewProjectTitle extends StatelessWidget {
  final String title;
  final bool editable;
  final ProjectModel project;
  final Function()? onEditMembers;
  final Function()? onEditLinks;
  const ViewProjectTitle({super.key,required this.title,this.editable = false,required this.project, this.onEditMembers, this.onEditLinks});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewProjectCubit>();
    File? presentation;
    String presentationPath;
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
            editable ?
            InkWell(
              onTap: title=="Members" ? onEditMembers : title=="Links" ? onEditLinks
              : () async {
                if (title == 'Presentation') {
                  presentation = await pickerFile();
                  if (presentation != null) {
                    presentationPath = presentation!.path;
                    await cubit.updatePresentation(projectId: project.projectId,presentationPath: presentationPath);
                  }
                }
                else if (title == 'Images') {
                  final selectedImages = await ImagePicker().pickMultiImage(limit: 4);
                  if (selectedImages.isNotEmpty) {
                    List<String> imgsPaths = selectedImages.map((img) => File(img.path).path).toList();
                    await cubit.updateImages(
                      imgs: imgsPaths,
                      projectId: project.projectId,
                      projectImages: project.imagesProject
                    );
                  }
                }
                else {
                  context.push(screen: EditBaseInfo(project: project));
                }
              },
              child: const Icon(Icons.edit,size: 15,color: AppConstants.iconsGrayColor,)
            ) : const SizedBox.shrink()
          ],
        ),
        const Divider(),
      ],
    );
  }
}