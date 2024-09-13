import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project7/layers/auth_layer.dart';

Future<void> initSetup() async {
  await GetStorage.init();
  GetIt.I.registerSingleton<AuthLayer>(AuthLayer());
}
