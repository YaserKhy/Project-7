import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';

class ViewProjectImages extends StatelessWidget {
  final HomeCubit cubit;
  final List<ImagesProject> images;
  const ViewProjectImages({super.key, required this.images, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return images.isEmpty ? const Text("No Images Added")
    : SizedBox(
      height: context.getHeight(divideBy: 5),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return cubit.handleLogo(
            logoUrl: images[index].url,
            context: context,
            heightDivide: 10,
            widthDivide: 3
          );
        },
        separatorBuilder: (context, index)=>const SizedBox(width: 20,)
      ),
    );
  }
}