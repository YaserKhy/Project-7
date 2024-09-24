import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProfileApi on ConstantAPi {
  Future<ProfileModel> getProfile({required String token}) async {
    try {
      final response = await dio.get(
        baseURl + getProfileEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );
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
    try {
      image = await File(imagePath!).readAsBytes();
    } catch (_) {}
    try {
      cv = await File(cvPath!).readAsBytes();
    } catch (_) {}
    try {
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
      await dio.put(
        baseURl + editProfileEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: datax,
      );
    } on DioException catch (e) {
      throw FormatException(e.toString());
    } catch (e) {
      throw FormatException(e.toString());
    }
  }
}
