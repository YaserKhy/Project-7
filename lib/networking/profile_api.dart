import 'dart:developer';

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

  Future<ProfileModel> editProfile({required ProfileModel profile}) async {
    final response = await dio.put(
      baseURl + editProfileEndPoint,
      data: {
        "first_name": profile.firstName,
        "last_name": profile.lastName,
        "image": profile.imageUrl,
        "cv": profile.link?.resume,
        "accounts": {
          "bindlink": profile.link?.bindlink,
          "linkedin": profile.link?.linkedin,
          "github": profile.link?.github
        }
      },
    );
    return response.data;
  }
}
