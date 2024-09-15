import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/models/auth_model.dart';
import 'package:project7/screens/login/login_screen.dart';
import 'package:project7/screens/my_projects/my_projects_screen.dart';
import 'package:project7/screens/navigation/navigation_screen.dart';
import 'package:project7/services/setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSetup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel? auth = GetIt.I.get<AuthLayer>().auth;
    return MaterialApp(home: auth==null ? const LoginScreen() : const NavigationScreen());
    // return const MaterialApp(home: MyProjectsScreen());
  }
}
