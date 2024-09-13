import 'package:get_storage/get_storage.dart';
import 'package:project7/models/auth_model.dart';

class AuthLayer {
  AuthModel? auth;
  final box = GetStorage();

  AuthLayerData() {
    loadDataAuth();
  }

  Future<void> saveAuth({required AuthModel authData}) async {
    auth = authData;
    await box.write("auth", authData.toJson());
  }

  Future<void> loadDataAuth() async {
    if (box.hasData('auth')) {
      auth = AuthModel.fromJson(
          Map.from(await box.read("auth")).cast<String, dynamic>());
    }
  }

  Future<void> logOut() async {
    box.erase();
    auth = null;
  }
}
