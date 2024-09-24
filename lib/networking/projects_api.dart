import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
      for (var projectAsMap in response.data['data']['projects']) {
        projects.add(ProjectModel.fromJson(projectAsMap));
      }
      return projects;
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  Future<void> createProject({required String userId,required String deadline,required bool allowEditing}) async {
    try {
      final response = await dio.post(
        baseURl + createProjectEndPoint,
        data: {
          "user_id": userId,
          "time_end_edit": deadline,
          "edit": allowEditing
        },
        options: Options(headers: {'Authorization': 'Bearer ${GetIt.I.get<AuthLayer>().auth!.token}'})
      );
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
      await dio.put(
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
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
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
      await dio.put(
        "$baseURl$changeProjectStatusEndPoint/$projectId",
        data: jsonEncode({
          "time_end_edit": '11/12/2024',
          "edit": isEditable,
          "rating": isRatable,
          "public": isPublic
        }),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
  editProjectPresentation({required String token,required String projectId,required String presentationPath,}) async {
    try {
      final presentation = await File(presentationPath).readAsBytes();
      await dio.put(
        "$baseURl$editProjectPresentationEndPoint/$projectId",
        data: jsonEncode({"presentation_file": presentation.toList(growable: false)}),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }


  deleteProject({required String token, required String projectId}) async {
    try {
      await dio.delete(
        "$baseURl$deleteProjectEndPoint/$projectId",
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  editProjectLogo({required String token,required String projectId,required String imgPath}) async {
    Uint8List? image;
    try {
      image = await File(imgPath).readAsBytes();
    } catch (_) {}
    try {
      await dio.put(
        '$baseURl$editProjectLogoEndPoint/$projectId',
        data: jsonEncode({"logo": image?.toList(growable: false)}),
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  editProjectImages({required String token, required String projectId, required List<String> imgsPaths, required List<ImagesProject> currentImages, String deletedUrl=""}) async {
    List<List<int>> result = [];
    try {
      for(var url in currentImages.map((img)=>img.url)) {
        final subResponse = await dio.get(url,options: Options(responseType: ResponseType.bytes));
        result.add(Uint8List.fromList(subResponse.data));
      }
      for (var path in imgsPaths) {
        Uint8List temp = File(path).readAsBytesSync();
        result.add(temp.toList(growable: false));
      }
      await dio.put(
        "$baseURl$editProjectImagesEndPoint/$projectId",
        data: jsonEncode({"images": result}),
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  deleteProjectImage({required String token, required String projectId, required ImagesProject imgToDelete, required List<ImagesProject> images}) async {
    List<List<int>> result = [];
    try {
      for(var img in images) {
        if(img.id==imgToDelete.id) {
          continue;
        }
        final subResponse = await dio.get(img.url,options: Options(responseType: ResponseType.bytes));
        result.add(Uint8List.fromList(subResponse.data));
      }
      await dio.put(
        "$baseURl$editProjectImagesEndPoint/$projectId",
        data: jsonEncode({"images": result}),
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  submitRating({required String token,required String projectId,required Map<String,dynamic> ratingData}) async {
    try {
      await dio.post(
        "$baseURl$rateProjectEndPoint/$projectId",
        data: jsonEncode(ratingData),
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  addMember({required String projectId, required List<Map<String,dynamic>> newData}) async {
    try {
      await dio.put(
        "$baseURl$addMembersEndpoint/$projectId",
        data: {"members": newData},
        options: Options(headers: {"Authorization" : "Bearer ${GetIt.I.get<AuthLayer>().auth!.token}"})
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }

  updateProjectLinks({required String token, required String projectId, required Map<String,dynamic> data}) async {
    List<Map<String,dynamic>> result = [];
    for (var type in data.keys.toList()) {
      if(data[type]!="") {
        result.add({"type" : type, "url": data[type]});
      }
    }
    try {
      await dio.put(
        "$baseURl$updateProjectLinksEndPoint/$projectId",
        data: {'link':result},
        options: Options(headers: {"Authorization" : "Bearer $token"}),
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}