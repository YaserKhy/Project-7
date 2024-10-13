import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/auth_model.dart';
import 'package:project7/screens/login/login_screen.dart';
import 'package:project7/screens/navigation/navigation_screen.dart';
import 'package:project7/services/setup.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSetup();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthModel? auth = GetIt.I.get<AuthLayer>().auth;
    return BlocProvider(
      create: (context) => SharedCubit()..getProfile(auth?.token),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: auth == null ? const LoginScreen() : const NavigationScreen()),
    );
  }
}