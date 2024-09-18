import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProfileApi on ConstantAPi {
  Future<ProfileModel> getProfile({required String token}) async {
    try {
      log("get1");

      final response = await dio.get(baseURl + getProfileEndPoint,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      log("get2");

      return ProfileModel.fromJson(response.data['data']);
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  editProfile({
    required String token,
    required String firstName,
    required String lastName,
    required String? imagePath,
    required String? cvPath,
    required String bindlink,
    required String github,
    required String linkedin,
  }) async {
    Uint8List? image;
    Uint8List? cv;
    bool validImage = false;
    bool validCv = false;
    try {
      image = await File(imagePath!).readAsBytes();
      validImage = true;
    } catch (_) {}
    try {
      cv = await File(cvPath!).readAsBytes();
      validCv = true;
    } catch (_) {}
    try {
      // log(image.toString());
      // log(cv.toString());
      // log(imagePath.toString());
      // log(cvPath.toString());
      String linkedinUsername = linkedin.split("/").last;
      final datax = {
        "first_name": firstName,
        "last_name": lastName,
        "image": image?.toList(growable: false),
        "cv": cv?.toList(growable: false),
        "accounts": {
          "bindlink": bindlink,
          "linkedin": linkedinUsername,
          "github": github
        }
      };
      datax.removeWhere((k, v) => v == null);
      print(datax);
      final response = await dio.put(
        baseURl + editProfileEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: datax,
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
