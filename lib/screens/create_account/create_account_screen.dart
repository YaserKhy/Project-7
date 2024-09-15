import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/create_account/bloc/create_account_bloc.dart';
import 'package:project7/screens/login/login_screen.dart';
import 'package:project7/screens/otp/otp_verification_screen.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/buttons/auth_text_button.dart';
import 'package:project7/widgets/fields/auth_field.dart';
import 'package:project7/widgets/texts/auth_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => CreateAccountBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<CreateAccountBloc>();
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BlocListener<CreateAccountBloc, CreateAccountState>(
              listener: (context, state) {
                if (state is LoadingState) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()));
                }

                if (state is SuccessState) {
                  Navigator.pop(context);
                  context.pushReplacement(
                      screen: OtpVerificationScreen(
                    email: bloc.controllerEmail!.text,
                  ));
                }
                if (state is ErrorState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.msg)));
                }
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Stack(children: [
                    Positioned(
                        bottom: 0,
                        child: Image.asset("assets/images/tuwaiq.png",
                            width: context.getWidth(), fit: BoxFit.cover)),
                    SizedBox(
                      height: context.getHeight(),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 36),
                              Image.asset("assets/images/tuwaiq_logo2.png",
                                  height: 105, width: 243),
                              const SizedBox(height: 48),
                              const AuthTitle(title: "Create Account"),
                              const SizedBox(height: 12),
                              AuthField(
                                label: "First name",
                                controller: bloc.controllerFName,
                                validator: (fName) {
                                  if (fName!.trim().isEmpty) {
                                    return 'First name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              AuthField(
                                label: "Last name",
                                controller: bloc.controllerLName,
                                validator: (lName) {
                                  if (lName!.trim().isEmpty) {
                                    return 'Last name is required';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              AuthField(
                                label: "Email",
                                controller: bloc.controllerEmail,
                                validator: (email) {
                                  if (email!.trim().isEmpty) {
                                    return 'Email is required';
                                  }
                                  String emailPattern =
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                  RegExp regex = RegExp(emailPattern);

                                  if (!regex.hasMatch(email)) {
                                    return 'Enter a valid email';
                                  }

                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              AuthButton(
                                  title: "Get Started",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(CreateEvent());
                                    }
                                  }),
                              AuthTextButton(
                                  text: "Have an account ?",
                                  button: "Log in",
                                  onPressed: () {
                                    context.pushReplacement(
                                        screen: const LoginScreen());
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ));
      }),
    );
  }
}
