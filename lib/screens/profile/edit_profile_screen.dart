import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/helpers/file_picker.dart';

import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/widgets/buttons/profile_button.dart';
import 'package:project7/widgets/fields/edit_field.dart';
import 'package:project7/widgets/fields/edit_link_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
    required this.profile,
  });
  final ProfileModel profile;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final shared = context.read<SharedCubit>();
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
    File? cv;
    String? imagePath = profile.imageUrl;
    String? cvPath = profile.resumeUrl;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppConstants.bgColor,
        appBar: AppBar(
          forceMaterialTransparency: true,
        ),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: shared
                        .handleProfilePage(
                            logoUrl: profile.imageUrl, context: context)
                        .image),
              TextButton(
                  onPressed: () async {
                    final selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    image = File(selectedImage!.path);
                    imagePath = image!.path;
                    profile.imageUrl = image?.path ?? profile.imageUrl;
                  },
                  child: const Text(
                    "Change image",
                    style: TextStyle(color: AppConstants.mainPurple),
                  )),
              const SizedBox(width: 12),
              ElevatedButton(
                  onPressed: () async {
                    cv = await pickerFile();
                    cvPath = cv!.path;
                  },
                  child: const Text('Upload cv')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditField(lebal: "First Name", controller: fNameController, width: 100,),
                  EditField(lebal: "Last Name", controller: lNameController, width: 100,),
                ],
              ),
              const SizedBox(height: 22),
            
                const SizedBox(width: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EditField(
                      lebal: "First Name",
                      controller: fNameController,
                      width: 150,
                    ),
                    EditField(
                      lebal: "Last Name",
                      controller: lNameController,
                      width: 150,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditLinkField(
                            maxWidth: 180,
                            icon: Icons.description_outlined,
                            hint: "Upload your cv link",
                            controller: resumeController),
                        TextButton(
                            onPressed: () async {
                              cv = await pickerFile();
                              cvPath = cv!.path;
                            },
                            child: const Text(
                              "Upload cv",
                              style: TextStyle(color: AppConstants.mainPurple),
                            )),
                      ],
                    ),
                    EditLinkField(
                        icon: CustomIcons.linkedin_in,
                        hint: "Enter your Linked in link",
                        controller: linkedinController),
                    EditLinkField(
                        icon: CustomIcons.github,
                        hint: "Enter your GitHub username",
                        controller: gitHubController),
                    EditLinkField(
                        icon: Icons.link,
                        hint: "Enter your Bindlink username",
                        controller: bindlinkController),
                    ProfileButton(
                      color: AppConstants.mainPurple,
                      title: "Save",
                      onPressed: () {
                        {
                          log(imagePath ?? "no image");
                          log(cvPath ?? "no cv");
                          log(linkedinController.text);
                          shared.editProfile(
                              token: GetIt.I.get<AuthLayer>().auth!.token,
                              firstName: fNameController.text,
                              bindLink: bindlinkController.text,
                              cvPath: cvPath,
                              github: gitHubController.text,
                              imagePath: imagePath,
                              lastName: lNameController.text,
                              linkedIn: linkedinController.text);
                          context.pop();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


