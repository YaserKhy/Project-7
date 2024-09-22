import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:flutter/material.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final api = NetworkingApi();
  static List<ProjectModel> projects = [];
  TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Map<String, dynamic> rating = {
    "idea":0.0,
    "design":0.0,
    "tools":0.0,
    "practices":0.0,
    "presentation":0.0,
    "investment":0.0,
    "note": ""
  };
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
    log(projects.map((p)=>p.projectName).toList().toString());
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

  showStars() {
    emit(ShowStarsState());
  }

  changeStars(String field,double newStars) {
    log('$field rating is $newStars');
    rating[field] = newStars;
    emit(StarChangedState(field: field, newStars:newStars));
  }

  submitRating() {
    // rating['note'] = commentController.text;
    // logic here to submit
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
