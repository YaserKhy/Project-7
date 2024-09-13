import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/login_screen.dart';
import 'package:project7/screens/otp_verification_screen.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/buttons/auth_text_button.dart';
import 'package:project7/widgets/fields/auth_field.dart';
import 'package:project7/widgets/texts/auth_title.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset("assets/images/tuwaiq.png", width: context.getWidth(),fit: BoxFit.cover)
              ),
              SizedBox(
                height: context.getHeight(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      Image.asset("assets/images/tuwaiq_logo2.png",height: 105,width: 243),
                      const SizedBox(height: 48),
                      const AuthTitle(title: "Create Account"),
                      const SizedBox(height: 12),
                      const AuthField(label: "First name"),
                      const SizedBox(height: 12),
                      const AuthField(label: "Last name"),
                      const SizedBox(height: 12),
                      const AuthField(label: "Email"),
                      const SizedBox(height: 44),
                      AuthButton(title: "Get Started",onPressed: ()=>context.pushRemove(screen: const OtpVerificationScreen())),
                      AuthTextButton(
                        text: "Have an account ? ",
                        button: "Log in",
                        onPressed: () => context.pushReplacement(screen: const LoginScreen()),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
