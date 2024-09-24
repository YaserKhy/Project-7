import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/project_model.dart';
part 'my_projects_state.dart';

class MyProjectsCubit extends Cubit<MyProjectsState> {
  static List<ProjectModel> myProjects = [];
  TextEditingController mySearchController = TextEditingController();
  MyProjectsCubit() : super(MyProjectsInitial());

  getMyProjects() {
    myProjects = GetIt.I.get<AuthLayer>().currentUser!.projects;
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