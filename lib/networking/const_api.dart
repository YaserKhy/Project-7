import 'package:dio/dio.dart';

class ConstantAPi {
  final dio = Dio();
  
  final String baseURl = "https://tuwaiq-gallery.onrender.com/v1";

  // auth
  final String createAccountEndPoint = "/auth/create/new/account";
  final String loginEndPoint = "/auth/login";
  final String verifyEndPoint = "/auth/verify";
  
  // profile
  final String getProfileEndPoint = "/user/profile";
  final String editProfileEndPoint = "/user/update/profile";
  
  // projects
  final String projectsEndPoint = '/projects';
  final String createProjectEndPoint = "/supervisor/create/project";
  final String changeProjectStatusEndPoint = "/supervisor/change/status";
  final String deleteProjectEndPoint = "/supervisor/delete/project";
  
  final String editProjectBaseEndPoint = "/user/edit/project/base";
  final String editProjectLogoEndPoint = "/user/edit/project/logo";
  final String editProjectImagesEndPoint = "/user/edit/project/images";
  final String rateProjectEndPoint = "/user/rating/project";
}