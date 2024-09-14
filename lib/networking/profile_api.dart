import 'package:dio/dio.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/const_api.dart';

mixin ProfileApi on ConstantAPi {
  Future<ProfileModel> getProfile({required String token}) async {
    final response = await dio.get(baseURl+getProfileEndPoint, options: Options(headers: {
      'Authorization' : 'Bearer $token'
    }));

    return ProfileModel.fromJson(response.data['data']);
  }
}