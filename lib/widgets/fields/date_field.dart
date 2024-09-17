import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/screens/add_project/add_project_screen.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.label, this.controller});
  final String label;
  final TextEditingController? controller;
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
        TextFormField(
          readOnly: true,
          onTap: () => selectDate(context),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffD9D9D9))),
            hintStyle: TextStyle(fontFamily: "Lato"),
            hintText: 'dd/MM/yyyy',
            suffixIcon: Icon(
              Icons.calendar_today,
              color: AppConstants.mainPurple,
            ),
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a date';
            }

            return null;
          },
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
