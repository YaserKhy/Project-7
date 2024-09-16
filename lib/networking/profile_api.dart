import 'dart:developer';
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
  Future<ProfileModel>  editProfile({
    required String token,
    required String firstName,
    required String lastName,
    required Future<Uint8List> image,
    required Future<Uint8List> cv,
    required String bindlink,
    required String github,
    required String linkedin,
  }) async {
    final response = await dio.put(
      baseURl + editProfileEndPoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
        "cv": cv,
        "accounts": {
          "bindlink": bindlink,
          "linkedin": linkedin,
          "github": github
        }
      },
    );
    print(response.statusCode);
    return response.data;
  }
}
