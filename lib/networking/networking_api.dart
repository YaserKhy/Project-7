import 'package:project7/networking/auth_api.dart';
import 'package:project7/networking/const_api.dart';
import 'package:project7/networking/profile_api.dart';
import 'package:project7/networking/projects_api.dart';

class NetworkingApi extends ConstantAPi with AuthApi, ProjectsApi, ProfileApi {}
