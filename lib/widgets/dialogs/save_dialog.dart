import 'package:flutter/material.dart';
import 'package:project7/extensions/screen_size.dart';

saveDialog({required BuildContext context, String? msg}) {
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
                Container(
                    width: 268,
                    height: 98,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/profile_decoration.png"))),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xff80D883),
                      child: Icon(
                        Icons.done,
                        size: 60,
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(height: 20),
                const Text(
                  "Saved Successfully",
                  style: TextStyle(fontFamily: "Lato", fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  msg ?? " ",
                  style:
                      const TextStyle(color: Color(0xff6D6D6D), fontSize: 12),
                ),
              ],
            ),
          ),
        );
      });
}
