import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  
  const AuthField(
      {super.key, required this.label, this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Lato")),
        const SizedBox(height: 8),
        SizedBox(
            width: context.getWidth() / 1.1,
            height: 46,
            child: TextFormField(
              
              keyboardType: label.toLowerCase() == 'email'
                  ? TextInputType.emailAddress
                  : null,
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff4D2EB4), width: .5),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: validator,
            ))
      ],
    );
  }
}
