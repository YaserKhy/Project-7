import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class EditField extends StatelessWidget {
  const EditField({
    super.key,
    required this.controller,
    required this.lebal,
  });

  final TextEditingController controller;
  final String lebal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lebal,
          style: const TextStyle(
              color: Color(0xff313131), fontSize: 14, fontFamily: "Lato"),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: context.getWidth(divideBy: 2.3),
              minHeight: 45,
              maxHeight: 45),
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
