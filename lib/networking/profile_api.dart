import 'package:dio/dio.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProfileApi on ConstantAPi {
  Future<ProfileModel> getProfile({required String token}) async {
    try {
      final response = await dio.get(baseURl + getProfileEndPoint,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return ProfileModel.fromJson(response.data['data']);
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  Future<ProfileModel> editProfile(
      {required String token, required ProfileModel profile}) async {
    final response = await dio.put(
      baseURl + editProfileEndPoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      data: {
        "first_name": profile.firstName,
        "last_name": profile.lastName,
        "image": profile.imageUrl.codeUnits,
        "cv": profile.resumeUrl?.codeUnits,
        "accounts": {
          "bindlink": profile.link?.bindlink,
          "linkedin": profile.link?.linkedin,
          "github": profile.link?.github
        }
      },
    );
    print(response.statusCode);
    return response.data;
  }
}
