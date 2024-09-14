import 'package:dio/dio.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProfileApi on ConstantAPi {
  Future<ProfileModel> getProfile({required String token}) async {
    final response = await dio.get(baseURl + getProfileEndPoint,
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    return ProfileModel.fromJson(response.data['data']);
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
