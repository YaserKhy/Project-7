import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:project7/models/auth_model.dart';
// import 'package:project7/models/project_model.dart';
// import 'package:project7/networking/networking_api.dart';

class AuthLayer {
  AuthModel? auth;
  // final List<ProjectModel> projects = [];
  final box = GetStorage();

  AuthLayer() {
    loadDataAuth();
    // if(box.hasData('projects')==false) {
    //   getProjectsFromApi();
    // }
  }

  Future<void> saveAuth({required AuthModel authData}) async {
    auth = authData;
    await box.write("auth", authData.toJson());
  }

  Future<void> loadDataAuth() async {
    if (box.hasData('auth')) {
      auth = AuthModel.fromJson(Map.from(await box.read("auth")).cast<String, dynamic>());
      log('token found ${auth?.token.substring(1,10)}');
    }
    else {
      log('token not found');
    }
  }

  // Future<void> getProjectsFromApi() async {
  //   log('loading projects ....');
  //   final api = NetworkingApi();
  //   List<ProjectModel> projectsApi = await api.getAllProjects();
  //   projects.addAll(projectsApi);
  //   box.write('projects',projects.map((e)=>e.toJson()));
  //   log('projects are in local ✅');
  // }

  // Future<void> loadProjects() async {
  //   List<Map<String,dynamic>> temp = List.from(box.read('projects')).cast<Map<String,dynamic>>();
  //   for (var element in temp) {
  //     projects.add(ProjectModel.fromJson(element));
  //   }
  //   log(projects.length.toString());
  //   log("Projects are ready ✅");
  // }

  Future<void> logOut() async {
    box.erase();
    auth = null;
  }
}