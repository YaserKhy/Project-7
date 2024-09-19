import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

class DropDown extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  DropDown({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Type",
          style: TextStyle(
              color: Color(0xff313131), fontSize: 16, fontFamily: "Lato"),
        ),
        DropdownMenu(
          controller: controller,
            inputDecorationTheme: const InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffD9D9D9))),
                filled: true,
                fillColor: Colors.white),
            enableSearch: true,
            width: context.getWidth() / 1.1,
            menuHeight: 200,
            menuStyle: MenuStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
            ),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: "app", label: "app"),
              DropdownMenuEntry(value: "website", label: "website"),
              DropdownMenuEntry(value: "vr", label: "vr"),
              DropdownMenuEntry(value: "ar", label: "ar"),
              DropdownMenuEntry(value: "ai", label: "ai"),
              DropdownMenuEntry(value: "ml", label: "ml"),
              DropdownMenuEntry(value: "ui/ux", label: "ui/ux"),
              DropdownMenuEntry(value: "gaming", label: "gaming"),
              DropdownMenuEntry(value: "unity", label: "unity"),
              DropdownMenuEntry(value: "cyber", label: "cyber"),
              DropdownMenuEntry(value: "software", label: "software"),
              DropdownMenuEntry(value: "automation", label: "automation"),
              DropdownMenuEntry(value: "robotic", label: "robotic"),
              DropdownMenuEntry(value: "api", label: "api"),
              DropdownMenuEntry(value: "analytics", label: "analytics"),
              DropdownMenuEntry(value: "iot", label: "iot"),
              DropdownMenuEntry(value: "cloud", label: "cloud")
            ]),
      ],
    );
  }
}
