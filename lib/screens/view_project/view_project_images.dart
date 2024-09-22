import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';

class ViewProjectImages extends StatelessWidget {
  final List<ImagesProject> images;
  const ViewProjectImages({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final shared = context.read<SharedCubit>();
    return images.isEmpty ? const Text("No Images Added")
    : SizedBox(
      height: context.getHeight(divideBy: 5),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return shared.handleLogo(
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