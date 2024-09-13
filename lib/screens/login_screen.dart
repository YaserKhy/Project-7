import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/create_account/create_account_screen.dart';
import 'package:project7/screens/otp/otp_verification_screen.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/buttons/auth_text_button.dart';
import 'package:project7/widgets/fields/auth_field.dart';
import 'package:project7/widgets/texts/auth_title.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Image.asset("assets/images/tuwaiq.png",width: context.getWidth(), fit: BoxFit.cover)
              ),
              SizedBox(
                height: context.getHeight(),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 44),
                            Image.asset("assets/images/tuwaiq_logo2.png",height: 105, width: 243),
                            const SizedBox(height: 44),
                            const AuthTitle(title: "Login"),
                            const SizedBox(height: 44),
                            AuthField(
                              label: "Email",
                              validator: (email) {
                                if (email!.trim().isEmpty) {
                                  return 'Email is required';
                                }
                                String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                RegExp regex = RegExp(emailPattern);
                                
                                if (!regex.hasMatch(email)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 44),
                            AuthButton(
                              title: "Login",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.pushReplacement(screen: const OtpVerificationScreen(email: ""));
                                }
                              }
                            ),
                            AuthTextButton(
                              text: "Don't have account ?",
                              button: "Sign up",
                              onPressed: () => context.pushReplacement(screen: const CreateAccountScreen()),
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
