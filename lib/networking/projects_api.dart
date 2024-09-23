import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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
            'Authorization':
                'Bearer MWJmNzc0ZWE1YWVlZWYxNTA4NmJkNTljMmVjNWJhMjAyNDc5YzE3ZjgwMTkyZDEwNjUxZDdjYjRhMDYwYTI3NWRlMTY0NDA4YTFhOGE4NGE1ZDMwZDhjYWNmYTNjNjJhN2VkMTBjYmVhNzZiNWNkNzg1YWQyZmE5MjczZmFmYzQ5Nzk5NmFlZTgwY2Q1ZWQ3YWY4NTM2MWFjZTUwMTdmNTY1OGY0NmJkMTljZTU1YmRkZGJjZDVmYmU5MDQzMjk4Yjc3ZDM5NTM1YmQ4MzRlMjc3YTFiMDliZGVkZDk5ODM2OTI4MzFlY2RhNWY3MmExNzYzNGMwNTAwYTAxNDEzNmM1ODFmMmVkZGQ3YmM5NWE5OWY3M2YxYWY0MDdhMDczNGQwOTE5YTczZTRjOTJmOTdhYzRmMDQ3NTk4NWFkMzA1N2ZjZjI1MTM1NWJhYmU1Y2FiMjE2MmVmZTU3ZTU1YTZiMmUxYTVhZTE2NzNkZTI4MmRiMTZmYjA0ZjUxMjBiNzk5NmFlM2EyZjE2YjQ1ZTg4MzQ4MjBmMzg1NGJhMjAyZDUzOWFjMGRhNDJlMWI0OGEwYjUxNGQyZWZjZWE3MjBkYmVmMzU5OTcwYzAyMjJhMmZmZjU5MTM4ZTVjYThiNTRhMTk0NTJjZjQ5YjAyYzlkNTU0MzBlZTQ1ZmYzZDg4M2UxMjYxM2ZjMjI4NTJjYWRhZmNhZGJiZDI5ZjY2NTI3ZjlkNThhMTAxZTEwY2IwMmMyMzNhZTU5NWQxYWQxZDc4ZTA5Mjk1OGQ4NzMyNjIzZGY1MTNjMzJlOWRjNWY5MzMzMGM4ZGQ3NzJmOGM0OWMzYTQzMGYwMGEwNzdmNzk1YWYxYzZkY2I5ZDU3OGNmYTU1NzgxYTgxZTI5MjhiMTVmZGNkZmI3NzJkMzFjYWRmOWY4MDU2NGI3YThiZWJhZGNmNzU4N2U1NWIzNjNmZDc4MTg3NTQ5ODlmOTQ1MmQxMDdlODJhZDAyODI0YWVjNDY4NmRhYjYxNmU3NTY4M2E2NDY4ZmE4YTczYjYxMmI5N2IyMDAyYjUxZTIyMjdhNjY4MzliZTgwZjRmYjQzNTJkNWI0Yjg2YTkxN2ExYzA4NGQyYjU0YTYxNWNiY2Y0ZWUzYjdjNThiZjFjZDYxOTFkN2E2MWI0ZWI3ZWUwMTllMDEyZGY2NmM5ZTViN2Q2NmJlNGY3NTM0MGNlZjhiNjg4OTNkYjA0NzNmNWJlODI2YjA3MjRhMjNkNjZhZGU3NTkyMzcyZGU0Yjg5NWMwMDgzNWUxN2EyMTZlODZjNTA1ODg3NTYxMzhkZjdlNTc4ODE4MWZiN2I4MzBjYTg5MDcyZTdkOTBiNmFmYjBlZWZlNGI4YzliYTczZTBmMmMyNTIzYTE4NmI1YjhlOTE5YjQzMTU4YzlmNDNlYWEyMmY3MTY3NzI2ZGQ0MjMyNmExZGI5OTYzYmI3ZDJmODBmMzdmODI2YTAyZjViOTNkYjgzYTc3MDRlNjNjNDU1MzBmMGRiM2ZiNTU3NDA4YTUyYWVkZWRjYmIwM2M1MzliNDg3NThkZGZmNGFmMjVlNWViYTcxY2NiN2ZjYjg1NTliYjM0ODNiNmIyODI5YmRlNTExYWVjNjAxMGM0NmNlYWZjYWM5ZjExMzUwZDUyY2VhNDVlNWMwMmNiNWQ0NDI3MjQwODlmM2YwMjk4YjJmOWZlZTAxNDZmNDkwY2E1OGY1Mzk0ZGNhZDRmNzg3ZGI5MDAzYmJhMDU3NjkyODZmMWJmZmE3OTQzZDhiYmExNDM2NDdhNzU1ZTk1MWQyNGE2MzliNDVhNjVlNGU1MDEwMjgwYmRkNTQ3OWMzZGZlYzgxY2Y2MzMxYjJlNjQ5MGM5YzFiNGNkMmYxNjcyMDc1N2MwZjYxOTU1YTc3ZGZiNjhkZDc4N2NlZmY1MDNmMTk5ZWQwZDAwMWRkYWMyMGU5MjRmZjFjNDVmNTM1NGFmNjM3YWNjOTAwYTgzMzFhM2U0MjQ4OTk4ZWIyMmM0ZWQxMjhjMGI2MzNlYWRjMWJiMmZhYmIyZWI0MjE0NTliZWM2ZGY3NDEyZGEyYjNhNzM5NWVkZjIxMTcxNWYxOWMxNjAwNDJkZTBkNGU2NTYwZjdjYTY5YmQ3M2IwMTAzNjE0ZjViOTU3ZTcwZjYyZTY0NDJiNjE3NzE0Mzc5MjhiNjdiZmQ2NGZmZTM5YTY0NWZlMTUyMjA5MzZjODc3NDBkYTM0YTU='
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
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
    } on DioException catch (e) {
      print("-----");
      print(e.response?.data.toString());
      print("-----");
    } catch (e) {
      log(e.toString());
    }
  }
}
