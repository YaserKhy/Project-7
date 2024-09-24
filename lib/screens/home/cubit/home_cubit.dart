import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final api = NetworkingApi();
  static List<ProjectModel> projects = [];
  TextEditingController searchController = TextEditingController();
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

  refreshHome() async {
    projects = await api.getAllProjects();
    emit(ShowProjectsState(projects: projects));
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
}