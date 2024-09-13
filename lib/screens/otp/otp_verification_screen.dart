import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/screens/home_screen.dart';
import 'package:project7/screens/otp/bloc/otp_bloc.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<OtpBloc>();
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: BlocListener<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is LoadingState) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) =>
                        const Center(child: CircularProgressIndicator()));
              }
              if (state is SuccessState) {
                log("success 1");
                Navigator.pop(context);
                log("success 2");

                context.pushReplacement(screen: const HomeScreen());
                log("success 3");
              }
              if (state is ErrorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("There error")));
              }
            },
            child: Scaffold(
                body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/tuwaiq_logo2.png',
                        height: 105, width: 243),
                    const SizedBox(height: 106),
                    const Text('OTP VERIFICATION',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Enter the OTP sent to - ',
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                        Text(email,
                            style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                    const SizedBox(height: 38),
                    Pinput(
                        keyboardType: TextInputType.number,
                        length: 6,
                        onTapOutside: (event) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        onCompleted: (otp) =>
                            bloc.add(VerifyEvent(email: email, otp: otp)),
                        defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          textStyle:
                              const TextStyle(fontFamily: 'Lato', fontSize: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color(0xff282828).withOpacity(.5),
                                  width: .6),
                              borderRadius: BorderRadius.circular(10)),
                        )),
                    const SizedBox(height: 38),
                    const Text('00:120 Sec',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Didn't receive code ? ",
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                        TextButton(
                            onPressed: () {},
                            style: const ButtonStyle(
                                padding:
                                    WidgetStatePropertyAll(EdgeInsets.zero)),
                            child: const Text("Re-send",
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff4f27b3)))),
                      ],
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      }),
    );
  }
}
