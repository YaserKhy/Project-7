import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:flutter/material.dart';
import 'package:project7/widgets/custom_icons_icons.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final api = NetworkingApi();
  List<ProjectModel> projects = [];
  TextEditingController searchController = TextEditingController();
  double currentStars = 0;
  HomeCubit() : super(HomeInitial());

  getAllProjects() async {
    try {
      emit(LoadingState());
      projects = await api.getAllProjects();
      emit(ShowProjectsState(projects: projects));
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }

  Map<String,List<ProjectModel>> getGroupedProjects(List<ProjectModel> allProjects) {
    Map<String,List<ProjectModel>> groupedProjects = {};
      for (var project in allProjects) {
      if (groupedProjects.containsKey(project.bootcampName)==false) {
        groupedProjects[project.bootcampName] = [];
      }
      groupedProjects[project.bootcampName]!.add(project);
    }
    return groupedProjects;
  }

  Widget handleLogo(
      {required String logoUrl,
      required BuildContext context,
      double? heightDivide,
      double? height,
      double? widthDivide}) {
    Widget placeholderLogo = Image.asset('assets/images/tuwaiq_logo1.png',
        width: height!=null ? null : context.getWidth(divideBy: widthDivide ?? 1),
        height: height ?? context.getHeight(divideBy: heightDivide ?? 10),
        fit: BoxFit.cover);
    return logoUrl.contains('assets')
        ? placeholderLogo
        : Image.network(logoUrl,
            width: context.getWidth(divideBy: widthDivide ?? 1),
            height: context.getHeight(divideBy: heightDivide ?? 10),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => placeholderLogo);
  }

  handleSearch(String term) {
    emit(LoadingState());
    List<ProjectModel> result = [];
    for (var project in projects) {
      if (project.projectName.toLowerCase().contains(term.toLowerCase())) {
        result.add(project);
      }
    }
    emit(ShowProjectsState(projects: result));
  }

  changeStars(double newStars) {
    try {
      emit(LoadingState());
      currentStars = newStars;
      emit(ShowBottomSheetState(newStars: currentStars));
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "Erorr with rating system"));
    }
  }

  Widget getLinkIcon(String type) {
    switch(type.toLowerCase()) {
      case 'github': return const Icon(CustomIcons.github, size: 25,);
      case 'figma': return Image.asset('assets/images/figma.png', width: 40);
      case 'video' : return const Icon(Icons.video_collection_outlined, size: 25,);
      case 'pinterest' : return const Icon(Icons.abc, size: 25);
      case 'playstore' : return const Icon(Icons.abc, size: 25);
      case 'applestore' : return const Icon(Icons.abc, size: 25);
      case 'apk' : return const Icon(Icons.abc, size: 25);
      case 'weblink' : return const Icon(Icons.abc, size: 25);
      default: return const Icon(Icons.accessibility_new_sharp, size: 25,);
    }
  }
}
