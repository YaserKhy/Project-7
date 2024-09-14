import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final api = NetworkingApi();
  List<ProjectModel> projects = [];
  TextEditingController searchController = TextEditingController();
  double currentStars = 0;
  HomeCubit() : super(HomeInitial());

  getAllProjects() async {
    projects = await api.getAllProjects();
    emit(ShowProjectsState(projects: projects));
  }

  List<ProjectModel> getBootcampProjects(String boot) {
    List<ProjectModel> bootProjects = [];
    for (var project in projects) {
      if(project.bootcampName == boot) {
        bootProjects.add(project);
      }
    }
    return bootProjects;
  }

  Widget handleLogo({required String logoUrl, required BuildContext context, double? heightDivide, double? widthDivide}) {
    Widget placeholderLogo = Image.asset(
      'assets/images/tuwaiq_logo1.png',
      width: context.getWidth(divideBy: widthDivide ?? 1),
      height: context.getHeight(divideBy: heightDivide ?? 10),
      fit: BoxFit.cover
    );
    return logoUrl.contains('assets') ? placeholderLogo :
    Image.network(
      logoUrl,
      width: context.getWidth(divideBy: widthDivide ?? 1),
      height: context.getHeight(divideBy: heightDivide ?? 10),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace)=> placeholderLogo
    );
  }

  handleSearch(String term) {
    List<ProjectModel> result = [];
    for (var project in projects) {
      if(project.projectName.toLowerCase().contains(term.toLowerCase())) {
        result.add(project);
      }
    }
    emit(ShowProjectsState(projects: result));
  }

  changeStars(double newStars) {
    currentStars = newStars;
    emit(ShowBottomSheetState(newStars: currentStars));
  }
}