import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';

warningDialog({required BuildContext context, Function()? onPressed}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            height: context.getHeight(divideBy: 4),
            width: context.getWidth(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/cancel.png"),
                const Text(
                  "Are you sure?",
                  style: TextStyle(fontFamily: "Lato", fontSize: 24),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xffFF5858),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xffFF5858)),
                              borderRadius: BorderRadius.circular(5)),
                          fixedSize: const Size(110, 30)),
                      onPressed: onPressed,
                      child: const Text("Yse"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xff6D6D6D),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xff6D6D6D)),
                              borderRadius: BorderRadius.circular(5)),
                          fixedSize: const Size(110, 30)),
                      onPressed: () => context.pop(),
                      child: const Text("No"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
