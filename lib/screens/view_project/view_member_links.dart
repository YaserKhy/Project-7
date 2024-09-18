import 'package:flutter/material.dart';
import 'package:project7/helpers/url_launcher.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class ViewMemberLinks extends StatelessWidget {
  final Link? links;
  const ViewMemberLinks({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> linksAsMap = links!.toJson();
    return Row(
      children: List.generate(linksAsMap.length, (index) {
        if (linksAsMap.keys.toList()[index] == 'github') {
          return InkWell(
            child: const Icon(CustomIcons.github),
            onTap: () {
              if (links?.github != null) {
                urlLuncher("https://github.com/${links!.github}");
              }
            },
          );
        } else if (linksAsMap.keys.toList()[index] == 'resume') {
          return InkWell(
            child: const Icon(CustomIcons.doc),
            onTap: () {
              if (links?.resume != null) {
                urlLuncher(links!.resume);
              }
            },
          );
        } else if (linksAsMap.keys.toList()[index] == 'linkedin') {
          return InkWell(
            child: const Icon(CustomIcons.linkedin_in),
            onTap: () {
              if (links?.linkedin != null) {
                urlLuncher("https://www.linkedin.com/in/${links?.linkedin}");
              }
            },
          );
        } else if (linksAsMap.keys.toList()[index] == 'bindlink') {
          return InkWell(
            child: const Icon(Icons.abc),
            onTap: () {
              if (links?.bindlink != null) {
                urlLuncher("https://bind.link/@${links?.bindlink}");
              }
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}
