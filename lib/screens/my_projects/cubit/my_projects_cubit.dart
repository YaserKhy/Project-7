import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/models/project_model.dart';

part 'my_projects_state.dart';

class MyProjectsCubit extends Cubit<MyProjectsState> {
  List<ProjectModel> myProjects = [];
  TextEditingController mySearchController = TextEditingController();
  MyProjectsCubit() : super(MyProjectsInitial());

  getMyProjects() {
    myProjects = GetIt.I.get<AuthLayer>().currentUser!.projects;
    log('My Projects : ${myProjects.length}');
    emit(ShowMyProjectsState(myProjects: myProjects));
  }

  Map<String,List<ProjectModel>> getGroupedProjects(List<ProjectModel> allMyProjects) {
    Map<String,List<ProjectModel>> groupedProjects = {};
      for (var project in allMyProjects) {
      if (groupedProjects.containsKey(project.bootcampName)==false) {
        groupedProjects[project.bootcampName] = [];
      }
      groupedProjects[project.bootcampName]!.add(project);
    }
    return groupedProjects;
  }

  Image handleLogo(
      {required String logoUrl,
      required BuildContext context,
      double? heightDivide,
      double? height,
      double? widthDivide}) {
    Image placeholderLogo = Image.asset('assets/images/tuwaiq_logo1.png',
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

  handleMySearch(String term) {
    emit(LoadingState());
    List<ProjectModel> result = [];
    for (var project in myProjects) {
      if (project.projectName.toLowerCase().contains(term.toLowerCase())) {
        result.add(project);
      }
    }
    emit(ShowMyProjectsState(myProjects: result));
  }
}
