import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/edit_project/edit_base_info.dart';

class ViewProjectTitle extends StatelessWidget {
  final String title;
  final bool editable;
  final ProjectModel project;
  const ViewProjectTitle({super.key, required this.title, this.editable=false, required this.project});

  @override
  Widget build(BuildContext context) {
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
              onTap: () {
                if(title == 'Presentation') {
                  log('Edit Presentation');
                }
                else if(title == 'Images') {
                  // context.push(screen: Images)
                  log('Edit Images');
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