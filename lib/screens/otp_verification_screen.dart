import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/tuwaiq_logo2.png', height: 105, width: 243),
              const SizedBox(height: 106),
              Text('OTP VERIFICATION', style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height:14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enter the OTP sent to - ', style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400)),
                  Text('Najwa@gmail.com', style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600))
                ],
              ),
              const SizedBox(height: 38),
              Pinput(
                
                keyboardType: TextInputType.number,
                length: 6,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                onCompleted: (value) {},
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  textStyle: GoogleFonts.lato(fontSize: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff282828).withOpacity(.5), width: .6),
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
              ),
              const SizedBox(height: 38),
              Text('00:120 Sec', style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive code ? ", style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w400)),
                  TextButton(
                    onPressed: (){},
                    style: const ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                    child: Text("Re-send", style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xff4f27b3)
                  )),),
                ],
              ),
              // tuwaiq mount photo here
            ],
          ),
        ),
      )
    );
  }
}
