import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:project7/models/auth_model.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/networking/networking_api.dart';

class AuthLayer {
  AuthModel? auth;
  ProfileModel? currentUser;
  final box = GetStorage();

  AuthLayer() {
    // box.erase();
    loadDataAuth();
  }

  Future<void> saveAuth({required AuthModel authData}) async {
    final api = NetworkingApi();
    await box.write("auth", authData.toJson());
    auth = authData;

    currentUser = await api.getProfile(token: authData.token);
    await box.write('currentUser', currentUser?.toJson());
  }

  Future<void> loadDataAuth() async {
    if (box.hasData('auth')) {
      auth = AuthModel.fromJson(
          Map.from(await box.read("auth")).cast<String, dynamic>());
      log('token found ${auth?.token}');
      currentUser = ProfileModel.fromJson(
          Map.from(await box.read('currentUser')).cast<String, dynamic>());
      log('user found ${currentUser?.firstName}');
    } else {
      log('token not found');
    }
  }

  Future<void> logOut() async {
    box.erase();
    auth = null;
  }
}
