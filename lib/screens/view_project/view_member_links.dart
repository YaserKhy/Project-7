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
        if (linksAsMap.keys.toList()[index] == 'github' && linksAsMap['github']!=null) {
          return InkWell(
            child: const Icon(CustomIcons.github),
            onTap: () => urlLuncher("https://github.com/${links!.github}"),
          );
        }
        else if (linksAsMap.keys.toList()[index] == 'resume' && linksAsMap['resume']!=null) {
          return InkWell(
            child: const Icon(CustomIcons.doc),
            onTap: ()=> urlLuncher(links!.resume),
          );
        }
        else if (linksAsMap.keys.toList()[index] == 'linkedin' && linksAsMap['linkedin']!=null) {
          return InkWell(
            child: const Icon(CustomIcons.linkedin_in),
            onTap: ()=> urlLuncher("https://www.linkedin.com/in/${links?.linkedin}"),
          );
        }
        else if (linksAsMap.keys.toList()[index] == 'bindlink' && linksAsMap['bindlink']!=null) {
          return InkWell(
            child: const Icon(Icons.link),
            onTap: ()=> urlLuncher("https://bind.link/@${links?.bindlink}"),
          );
        }
        else { return const SizedBox.shrink(); }
      }),
    );
  }
}