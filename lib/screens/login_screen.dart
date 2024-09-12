import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/create_account_screen.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/buttons/auth_text_button.dart';
import 'package:project7/widgets/fields/auth_field.dart';
import 'package:project7/widgets/texts/auth_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Stack(children: [
          Column(
            children: [
              const SizedBox(height: 48),
              Image.asset(
                "assets/tuwaiq_logo2.png",
                height: 105,
                width: 243,
              ),
              const SizedBox(height: 48),
              const AuthTitle(
                title: "Log In",
              ),
              const SizedBox(height: 84),
              const AuthField(label: "Email"),
              const SizedBox(height: 128),
              AuthButton(
                title: "Get Started",
                onPressed: () {},
              ),
              AuthTextButton(
                text: "Don’t have account ?",
                button: "Sign up",
                onPressed: () =>
                    context.push(screen: const CreateAccountScreen()),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 10,
            left: 10,
            child: Image.asset(
              width: context.getWidth(),
              "assets/tuwaiq.png",
            ),
          )
        ]),
      ),
    ));
  }
}
