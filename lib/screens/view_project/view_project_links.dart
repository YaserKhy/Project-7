import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/view_project/poject_link.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class ViewProjectLinks extends StatelessWidget {
  final List<LinksProject> links;
  const ViewProjectLinks({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: links.length,
        itemBuilder: (context, index) {
          if (links[index].type == 'github') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(CustomIcons.github,
                    color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'figma') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(
                  Icons.face,
                  color: AppConstants.iconsGrayColor,
                ),
                urlPath: links[index].url);
          }
          if (links[index].type == 'video') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(Icons.video_collection_outlined,
                    color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'pinterest') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(CustomIcons.doc,
                    color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'playstore') {
            return ProjectLink(
                title: links[index].type,
                icon:
                    const Icon(Icons.place, color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'applestore') {
            return ProjectLink(
                title: links[index].type,
                icon:
                    const Icon(Icons.apple, color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'apk') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(Icons.apartment,
                    color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          if (links[index].type == 'weblink') {
            return ProjectLink(
                title: links[index].type,
                icon: const Icon(Icons.web, color: AppConstants.iconsGrayColor),
                urlPath: links[index].url);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
