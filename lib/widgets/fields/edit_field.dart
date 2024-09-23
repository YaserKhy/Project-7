import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Widget? prefixIcon;
  final bool validate;
  final double? width;
  final double? maxHeight;
  final double? minHeight;
  final int? maxLines;
  final bool isProfile;
  const EditField({super.key,required this.controller,required this.label,this.prefixIcon,this.width,this.maxHeight,this.minHeight,this.maxLines, this.validate=true, this.isProfile=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: const TextStyle(color: Color(0xff313131), fontSize: 16, fontFamily: "Lato")),
        Container(
          width: isProfile ? 150 : null,
          child: TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: !validate ? null : (value) {
              if (controller.text.trim().isEmpty) {
                return 'this field is required';
              }
              return null;
            },
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(8),
              border: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffd9d9d9))),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xffd9d9d9))),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppConstants.mainPurple))
        ),
      ),
    ),
    const SizedBox(height: 10),
    ]);
  }
}