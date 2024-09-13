import 'dart:developer';

import 'package:project7/models/project_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProjectsApi on ConstantAPi {
  Future<List<ProjectModel>>getAllProjects() async {
    List<ProjectModel> projects = [];
    final response = await dio.get(baseURl + projectsEndPoint);
    // log(response.data.toString());
    for (var projectAsMap in response.data['data']['projects']) {
      projects.add(ProjectModel.fromJson(projectAsMap));
    }
    log(projects.length.toString());
    return projects;
  }
}