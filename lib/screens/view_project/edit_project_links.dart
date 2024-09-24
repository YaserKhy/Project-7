import 'package:flutter/material.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/fields/edit_field.dart';

class EditProjectLinks extends StatelessWidget {
  final String projectId;
  final List<LinksProject> links;
  final ViewProjectCubit? cubit;
  const EditProjectLinks({super.key, required this.links, this.cubit, required this.projectId});

  @override
  Widget build(BuildContext context) {
    TextEditingController githubController = TextEditingController(text: links.map((link)=>link.type).toList().contains('github') ? links.where((link)=>link.type=='github').first.url : null);
    TextEditingController figmaController = TextEditingController(text: links.map((link)=>link.type).toList().contains('figma') ? links.where((link)=>link.type=='figma').first.url : null);
    TextEditingController videoController = TextEditingController(text: links.map((link)=>link.type).toList().contains('video') ? links.where((link)=>link.type=='video').first.url : null);
    TextEditingController pinterestController = TextEditingController(text: links.map((link)=>link.type).toList().contains('pinterest') ? links.where((link)=>link.type=='pinterest').first.url : null);
    TextEditingController playstoreController = TextEditingController(text: links.map((link)=>link.type).toList().contains('playstore') ? links.where((link)=>link.type=='playstore').first.url : null);
    TextEditingController appleController = TextEditingController(text: links.map((link)=>link.type).toList().contains('applestore') ? links.where((link)=>link.type=='applestore').first.url : null);
    TextEditingController apkController = TextEditingController(text: links.map((link)=>link.type).toList().contains('apk') ? links.where((link)=>link.type=='apk').first.url : null);
    TextEditingController webController = TextEditingController(text: links.map((link)=>link.type).toList().contains('weblink') ? links.where((link)=>link.type=='weblink').first.url : null);
    return GestureDetector(
      onTap: ()=> FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppConstants.bgColor,
        appBar: AppBar(
          backgroundColor: AppConstants.bgColor,
          centerTitle: true,
          forceMaterialTransparency: true,
          title: const Text(
            "Edit Links",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppConstants.mainPurple,
              fontSize: 24,
              fontFamily: "Lato"
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(8, (index){
                      List controllers = [githubController, figmaController, videoController, pinterestController, playstoreController, appleController, apkController, webController];
                      List labels = ["github", "figma", "video", "pinterest", "play store", "apple store", "apk", "weblink"];
                      return EditField(controller: controllers[index], label: labels[index],validate: false,prefixIcon: cubit!.getLinkIcon(labels[index]));
                    }),
                    SizedBox(height: 5),
                    AuthButton(
                      title: "Save Links",
                      onPressed: () {
                        cubit!.updateProjectLinks(
                        projectId: projectId,
                        data: {
                          "github" : githubController.text,
                          "figma" : figmaController.text,
                          "video" : videoController.text,
                          "pinterest" : pinterestController.text,
                          "playstore" : playstoreController.text,
                          "applestore" : appleController.text,
                          "apk" : apkController.text,
                          "weblink" : webController.text
                        }
                      );
                      context.popAndSave();
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}