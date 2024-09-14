import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/screens/profile/cubit/profile_cubit.dart';
import 'package:project7/widgets/buttons/profile_button.dart';
import 'package:project7/widgets/fields/edit_field.dart';
import 'package:project7/widgets/fields/edit_field_row.dart';
import 'package:project7/widgets/texts/profile_title.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
    required this.profile,
    required this.cubit,
  });
  final ProfileModel profile;
  final ProfileCubit cubit;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    TextEditingController fNameController =
        TextEditingController(text: profile.firstName);
    TextEditingController lNameController =
        TextEditingController(text: profile.lastName);
    TextEditingController resumeController =
        TextEditingController(text: profile.link?.resume);
    TextEditingController linkedinController =
        TextEditingController(text: profile.link?.linkedin);
    TextEditingController gitHubController =
        TextEditingController(text: profile.link?.github);
    TextEditingController bindlinkController =
        TextEditingController(text: profile.link?.bindlink);

    File? image;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 89,
                        width: 89,
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: cubit
                                .handleProfilePage(
                                    logoUrl: profile.imageUrl, context: context)
                                .image),
                      ),
                      TextButton(
                          onPressed: () async {
                            final selectedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            image = File(selectedImage!.path);
                          },
                          child: const Text(
                            "Change image",
                            style: TextStyle(color: AppConstants.mainPurple),
                          ))
                    ],
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditField(
                          lebal: "First Name", controller: fNameController),
                      EditField(
                          lebal: "Last Name", controller: lNameController),
                    ],
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.all(20), child: Divider()),
              const ProfileTitle(title: "Links"),
              const SizedBox(height: 22),
              EditFieldRow(lebal: "Resume", controller: resumeController),
              EditFieldRow(lebal: "Linked in", controller: linkedinController),
              EditFieldRow(lebal: "GitHub", controller: gitHubController),
              EditFieldRow(lebal: "Bindlink", controller: bindlinkController),
              const SizedBox(height: 22),
              ProfileButton(
                title: "Save",
                color: AppConstants.mainPurple,
                onPressed: () {
                  cubit.editProfile(profileModel: profile);
                  context.pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
