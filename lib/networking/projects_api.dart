import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProjectsApi on ConstantAPi {
  Future<List<ProjectModel>> getAllProjects() async {
    try {
      List<ProjectModel> projects = [];
      final response = await dio.get(baseURl + projectsEndPoint);
      // log(response.data.toString());
      for (var projectAsMap in response.data['data']['projects']) {
        projects.add(ProjectModel.fromJson(projectAsMap));
      }
      log(projects.length.toString());
      return projects;
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  Future<void> createProject(
      {required String userId,
      required String deadline,
      required bool allowEditing}) async {
    try {
      final response = await dio.post(baseURl + createProjectEndPoint,
          data: {
            "user_id": userId,
            "time_end_edit": deadline,
            "edit": allowEditing
          },
          options: Options(headers: {
            'Authorization': 'Bearer ${GetIt.I.get<AuthLayer>().auth!.token}'
          }));
      return response.data["data"];
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  editProjectBaseInfo({
    required String token,
    required String id,
    required String name,
    required String bootcamp,
    required String type,
    required String description,
    required String startDate,
    required String endDate,
    required String presentationDate,
  }) async {
    try {
      log("$baseURl$editProjectBaseEndPoint/$id");
      final response = await dio.put(
        "$baseURl$editProjectBaseEndPoint/$id",
        data: jsonEncode({
          "project_name": name,
          "bootcamp_name": bootcamp,
          "type": type,
          "start_date": startDate,
          "end_date": endDate,
          "presentation_date": presentationDate,
          "project_description": description
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.data}');
    } on DioException catch (e) {
      log("-----");
      print(e.response?.data.toString());
      log("-----");
    } catch (e) {
      log(e.toString());
    }
  }

  editProjectStatus({
    required String token,
    required String projectId,
    required String endDate,
    required bool isEditable,
    required bool isRatable,
    required bool isPublic,
  }) async {
    try {
      final response = await dio.put(
        "$baseURl$changeProjectStatusEndPoint/$projectId",
        data: jsonEncode({
          "time_end_edit": '11/12/2024',
          "edit": isEditable,
          "rating": isRatable,
          "public": isPublic
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.data}');
    } on DioException catch (e) {
      log("-----");
      print(e.response?.data.toString());
      log("-----");
    } catch (e) {
      log(e.toString());
    }
  }

  deleteProject({required String token, required String projectId}) async {
    try {
      log("$baseURl$deleteProjectEndPoint/$projectId");
      final response = await dio.delete(
          "$baseURl$deleteProjectEndPoint/$projectId",
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.data}');
    } on DioException catch (e) {
      log("-----");
      print(e.response?.data.toString());
      log("-----");
    } catch (e) {
      log(e.toString());
    }
  }
}
