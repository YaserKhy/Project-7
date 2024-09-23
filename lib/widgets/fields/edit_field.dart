import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.controller,
    required this.label,
    this.width,
    this.maxHeight,
    this.minHeight,
    this.maxLines,
  });

  final TextEditingController controller;
  final String label;
  final double? width;
  final double? maxHeight;
  final double? minHeight;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: const TextStyle(color: Color(0xff313131), fontSize: 16, fontFamily: "Lato")),
        Container(
          child: TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) {
              if (controller.text.trim().isEmpty) {
                return 'this field is required';
              }
              return null;
            },
            maxLines: maxLines,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(8),
              border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffd9d9d9))),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffd9d9d9))),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppConstants.mainPurple))
        ),
      ),
    ),
    const SizedBox(height: 10),
    ]);
  }
}