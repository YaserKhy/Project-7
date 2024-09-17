import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/widgets/dialogs/warning_dialog.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key, this.onSave, this.onCancel});
  final Function()? onSave;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xff9B9B9B),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xff9B9B9B)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(130, 30)),
              onPressed: onCancel,
              child: const Text("Cancel")),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.mainPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppConstants.mainPurple),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  fixedSize: const Size(130, 30)),
              onPressed: onSave,
              child: const Text("Add")),
        ],
      ),
    );
  }
}
