import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';

import 'package:project7/widgets/buttons/edit_button.dart';
import 'package:project7/widgets/dialogs/warning_dialog.dart';
import 'package:project7/widgets/fields/date_field.dart';
import 'package:project7/widgets/fields/drop_down.dart';

import 'package:project7/widgets/fields/edit_field.dart';
import 'package:project7/widgets/texts/profile_title.dart';

class EditBaseInfo extends StatelessWidget {
  const EditBaseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppConstants.bgColor,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Edit Project",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppConstants.mainPurple,
                  fontSize: 24,
                  fontFamily: "Lato"),
            ),
            forceMaterialTransparency: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 10),
                  EditField(
                    lebal: "Project name",
                    controller: controller,
                  ),
                  EditField(
                    lebal: "Bootcamp",
                    controller: controller,
                  ),
                  const DropDown(),
                  const SizedBox(height: 10),
                  EditField(
                    controller: controller,
                    lebal: "project Description",
                    minHeight: 300,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  const ProfileTitle(title: "Dates"),
                  const Divider(),
                  const SizedBox(height: 10),
                  const DateField(label: "Start Date"),
                  const DateField(label: "End Date"),
                  const DateField(label: "Presentation Date"),
                  EditButton(
                    onCancel: () {
                      warningDialog(context: context);
                      context.pop();
                    },
                    onSave: () {},
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

//app, website, vr, ar, ai, ml, ui/ux, gaming, unity, cyber, software, automation, robotic, api, analytics, iot, cloud