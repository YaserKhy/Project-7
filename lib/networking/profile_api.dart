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
    final response = await dio.put(
      baseURl + editProfileEndPoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: jsonEncode({
        "first_name": firstName,
        "last_name": lastName,
        "image": validImage ? image!.toList(growable: false): null,
        "cv": validImage ?  cv!.toList(growable: false): null,
        "accounts": {
          "bindlink": bindlink,
          "linkedin": linkedin,
          "github": github
        }
      }),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.data}');
  }
}
