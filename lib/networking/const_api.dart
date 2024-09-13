import 'package:dio/dio.dart';

class ConstantAPi {
  final dio = Dio();
  final String baseURl = "https://tuwaiq-gallery.onrender.com/v1";
  final String createAccountEndPoint = "/auth/create/new/account";
  final String loginEndPoint = "/auth/login";
  final String verifyEndPoint = "/auth/verify";
  final String getProfileEndPoint = "/user/profile";
  final String projectsEndPoint = '/projects';
}
