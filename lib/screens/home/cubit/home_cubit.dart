import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final api = NetworkingApi();
  List<ProjectModel> projects = [];
  HomeCubit() : super(HomeInitial());

  getAllProjects() async {
    projects = await api.getAllProjects();
    emit(ShowProjectsState(projects: projects));
  }

  int getBootLength(String boot) {
    List<ProjectModel> bootProjects = [];
    for (var project in projects) {
      if(project.bootcampName == boot) {
        bootProjects.add(project);
      }
    }
    return bootProjects.length;
  }
}