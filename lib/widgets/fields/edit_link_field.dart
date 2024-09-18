import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class EditLinkField extends StatelessWidget {
  const EditLinkField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxWidth,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(width: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: maxWidth ?? context.getWidth(divideBy: 1.5),
                minHeight: 45,
                maxHeight: 45),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffD9D9D9))),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintStyle: const TextStyle(
                        color: Color(0xff313131),
                        fontSize: 14,
                        fontFamily: "Lato"),
                    hintText: hint,
                    contentPadding: const EdgeInsets.all(8),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
