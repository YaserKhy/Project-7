import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

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
        Text(
          label,
          style: const TextStyle(
              color: Color(0xff313131), fontSize: 16, fontFamily: "Lato"),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: width ?? context.getWidth(),
              minHeight: maxHeight ?? 45,
              maxHeight: minHeight ?? 45),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xffD9D9D9))),
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
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
