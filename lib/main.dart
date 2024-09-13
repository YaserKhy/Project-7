import 'package:flutter/material.dart';
import 'package:project7/screens/login/login_screen.dart';
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
    return const MaterialApp(home: LoginScreen());
  }
}
