import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class AuthField extends StatelessWidget {
  const AuthField({super.key, required this.label, this.controller});
  final String label;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontFamily: "Lato")),
        const SizedBox(height: 8),
        Container(
            width: context.getWidth() / 1.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xff4D2EB4))),
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ))
      ],
    );
  }
}
