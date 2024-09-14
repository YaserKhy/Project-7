import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class EditFieldRow extends StatelessWidget {
  const EditFieldRow({
    super.key,
    required this.controller,
    required this.lebal,
  });

  final TextEditingController controller;
  final String lebal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            lebal,
            style: const TextStyle(
                color: Color(0xff313131), fontSize: 14, fontFamily: "Lato"),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: context.getWidth(divideBy: 1.5),
                minHeight: 45,
                maxHeight: 45),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color(0xffD9D9D9))),
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
