import 'package:dio/dio.dart';
import 'package:project7/models/auth_model.dart';
import 'const_api.dart';

mixin AuthApi on ConstantAPi {
  Future<String> createNewAccount(
      {required String email,
      required String firstName,
      required String lastName}) async {
    try {
      print(baseURl + createAccountEndPoint);
      final response = await dio.post(baseURl + createAccountEndPoint, data: {
        "email": email.trim(),
        "f_name": firstName.trim(),
        "l_name": lastName.trim()
      });
      return response.data["data"]["email"];
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }

  //----------------------
  Future<AuthModel> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dio.post(baseURl + verifyEndPoint, data: {
        "email": email.trim(),
        "otp": otp.trim(),
      });
      return AuthModel.fromJson(response.data["data"]);
    } on DioException catch (error) {
      throw FormatException(error.response?.data["data"]);
    } catch (error) {
      throw const FormatException("~there error with API");
    }
  }
}
