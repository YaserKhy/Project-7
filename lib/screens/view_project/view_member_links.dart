import 'package:flutter/material.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class ViewMemberLinks extends StatelessWidget {
  final Link? links;
  const ViewMemberLinks({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    Map<String,dynamic> linksAsMap = links!.toJson();
    return Row(
      children: List.generate(linksAsMap.length, (index){
        if(linksAsMap.keys.toList()[index]=='github') {
          return const Icon(CustomIcons.github);
        }
        else if(linksAsMap.keys.toList()[index]=='resume') {
          return const Icon(CustomIcons.doc);
        }
        else if(linksAsMap.keys.toList()[index]=='linkedin') {
          return const Icon(CustomIcons.linkedin_in);
        }
        else if(linksAsMap.keys.toList()[index]=='bindlink') {
          return const Icon(Icons.abc);
        }
        else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}