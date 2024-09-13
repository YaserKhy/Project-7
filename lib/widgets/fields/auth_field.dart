import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  const AuthField({super.key, required this.label, this.controller});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Lato")),
        const SizedBox(height: 8),
        Container(
          width: context.getWidth() / 1.1,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xff4D2EB4), width: .5)
          ),
          child: TextFormField(
            keyboardType: label.toLowerCase()=='email' ? TextInputType.emailAddress : null,
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(borderSide: BorderSide.none)
            ),
          )
        )
      ],
    );
  }
}