import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/helpers/file_picker.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/widgets/buttons/profile_button.dart';
import 'package:project7/widgets/fields/edit_field.dart';
import 'package:project7/widgets/fields/edit_link_field.dart';
import 'package:project7/widgets/icons/custom_icons_icons.dart';

class EditProfileScreen extends StatelessWidget {

  final ProfileModel profile;
  const EditProfileScreen({super.key,required this.profile});
  
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final shared = context.read<SharedCubit>();
    TextEditingController fNameController = TextEditingController(text: profile.firstName);
    TextEditingController lNameController = TextEditingController(text: profile.lastName);
    TextEditingController resumeController = TextEditingController(text: profile.link?.resume);
    TextEditingController linkedinController = TextEditingController(text: profile.link?.linkedin);
    TextEditingController gitHubController = TextEditingController(text: profile.link?.github);
    TextEditingController bindlinkController = TextEditingController(text: profile.link?.bindlink);
    File? image;
    File? cv;
    String? imagePath = profile.imageUrl;
    String? cvPath = profile.resumeUrl;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppConstants.bgColor,
        appBar: AppBar(forceMaterialTransparency: true),
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async {
                    final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if(selectedImage!=null) {
                      image = File(selectedImage.path);
                      imagePath = image!.path;
                      profile.imageUrl = image?.path ?? profile.imageUrl;
                    }
                  },
                  child: Badge(
                    label: const Icon(Icons.edit, size: 12, color: Colors.white,),
                    backgroundColor: AppConstants.mainPurple,
                    alignment: const Alignment(.8, .65),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.transparent,
                      backgroundImage: shared.handleProfilePage(logoUrl: profile.imageUrl, context: context).image
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () async {
                    cv = await pickerFile();
                    if(cv != null) {
                      cvPath = cv!.path;
                    }
                  },
                  child: const Text('Upload cv')
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EditField(label: "First Name",controller: fNameController,width: 150,),
                    EditField(label: "Last Name",controller: lNameController,width: 150,),
                  ],
                ),
                const SizedBox(height: 22),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EditLinkField(icon: Icons.description_outlined,hint: "Upload your cv link",controller: resumeController),
                    EditLinkField(icon: CustomIcons.linkedin_in,hint: "Enter your Linked in link",controller: linkedinController),
                    EditLinkField(icon: CustomIcons.github,hint: "Enter your GitHub username",controller: gitHubController),
                    EditLinkField(icon: Icons.link,hint: "Enter your Bindlink username",controller: bindlinkController),
                    ProfileButton(
                      color: AppConstants.mainPurple,
                      title: "Save",
                      onPressed: () {
                        if(formKey.currentState!.validate()) {
                          log(imagePath ?? "no image");
                          log(cvPath ?? "no cv");
                          log(linkedinController.text);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => const Center(child: CircularProgressIndicator())
                          );
                          shared.editProfile(
                            token: GetIt.I.get<AuthLayer>().auth!.token,
                            firstName: fNameController.text,
                            bindLink: bindlinkController.text,
                            cvPath: cvPath,
                            github: gitHubController.text,
                            imagePath: imagePath,
                            lastName: lNameController.text,
                            linkedIn: linkedinController.text
                          ).then((_){
                            context.pop();
                            context.popAndSave();
                          });
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