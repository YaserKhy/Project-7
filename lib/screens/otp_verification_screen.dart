import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/screens/navigation/navigation_screen.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/tuwaiq_logo2.png', height: 105, width: 243),
                const SizedBox(height: 106),
                const Text('OTP VERIFICATION', style: TextStyle(fontFamily: 'Lato',fontSize: 18, fontWeight: FontWeight.w500)),
                const SizedBox(height:14),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Enter the OTP sent to - ', style: TextStyle(fontFamily: 'Lato',fontSize: 14, fontWeight: FontWeight.w400)),
                    Text('Najwa@gmail.com', style: TextStyle(fontFamily: 'Lato',fontSize: 14, fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(height: 38),
                Pinput(
                  keyboardType: TextInputType.number,
                  length: 6,
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                  onCompleted: (value) =>context.pushReplacement(screen: const NavigationScreen()),
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    textStyle: const TextStyle(fontFamily: 'Lato',fontSize: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff282828).withOpacity(.5), width: .6),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ),
                const SizedBox(height: 38),
                const Text('00:120 Sec', style: TextStyle(fontFamily: 'Lato',fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive code ? ", style: TextStyle(fontFamily: 'Lato',fontSize: 15, fontWeight: FontWeight.w400)),
                    TextButton(
                      onPressed: (){},
                      style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      child: const Text(
                        "Re-send",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xff4f27b3)
                    )
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
