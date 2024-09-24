import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/create_account/create_account_screen.dart';
import 'package:project7/screens/login/bloc/login_bloc.dart';
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<LoginBloc>();
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoadingState) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const Center(child: CircularProgressIndicator())
                );
              }
              if (state is SuccessState) {
                context.pop();
                context.pushReplacement(screen: OtpVerificationScreen(email: bloc.controllerEmail!.text));
              }
              if (state is ErrorState) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
              }
            },
            child: Scaffold(
              backgroundColor: AppConstants.bgColor,
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Image.asset("assets/images/tuwaiq_main_Screens.png",width: context.getWidth(), fit: BoxFit.cover)
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
                                    controller: bloc.controllerEmail,
                                    validator: (email) {
                                      if (email!.trim().isEmpty) {
                                        return 'Email is required';
                                      }
                                      RegExp regex = RegExp(AppConstants.emailRegex);
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
                                        bloc.add(SubmitLoginEvent());
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
          ),
        );
      }),
    );
  }
}