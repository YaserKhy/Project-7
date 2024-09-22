import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';

class EditButton extends StatelessWidget {
  final Function()? onSave;
  final Function()? onCancel;
  final String buttonText;
  const EditButton({super.key, this.onSave, this.onCancel, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: onCancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xff9B9B9B),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xff9B9B9B)),
                borderRadius: BorderRadius.circular(5),
              ),
              fixedSize: const Size(130, 30)
            ),
            child: const Text("Cancel")
          ),
          ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppConstants.mainPurple,
              foregroundColor: Colors.white,
              fixedSize: const Size(130, 30),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppConstants.mainPurple),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(buttonText)
          ),
        ],
      ),
    );
  }
}
