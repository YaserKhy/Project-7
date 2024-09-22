import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/global_cubit/shared_cubit.dart';
import 'package:project7/helpers/url_launcher.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:project7/screens/edit_project/edit_base_info.dart';
import 'package:project7/screens/home/cubit/home_cubit.dart';
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart' as v_cubit;
import 'package:project7/screens/view_project/view_project_images.dart';
import 'package:project7/screens/view_project/view_project_links.dart';
import 'package:project7/screens/view_project/view_project_member.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/screens/view_project/view_rating_project.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit homeCubit;
  final ProjectModel project;
  const ProjectScreen({super.key, required this.project, required this.homeCubit});
  @override
  Widget build(BuildContext context) {
    File? image;
    String? imgPath = project.logoUrl;
    final shared = context.read<SharedCubit>();
    return BlocProvider(
      create: (context) => v_cubit.ViewProjectCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<v_cubit.ViewProjectCubit>();
        String currentState = cubit.currentState(project: project);
        String currentRating = cubit.currentRatingState(project: project);
        String currentEditing = cubit.currentEditingState(project: project);
        return BlocListener<v_cubit.ViewProjectCubit, v_cubit.ViewProjectState>(
          listener: (context, state) {
            if (state is v_cubit.LoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator())
              );
            }
            if (state is v_cubit.ErrorState) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            }
            if (state is v_cubit.SuccessState) {
              context.popAndSave(); // exit loading
              context.popAndSave(); // back home
            }
          },
          child: Scaffold(
            backgroundColor: AppConstants.bgColor,
            appBar: AppBar(backgroundColor: AppConstants.bgColor),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  // whole content is a scrollable column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1 : Main Info
                      Center(
                        child: Column(
                          children: [
                            // project logo
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: shared.canEdit(project: project) == false ? null : () async {
                                final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                // if user actually selects an image
                                if (selectedImage != null) {
                                  image = File(selectedImage.path);
                                  imgPath = image!.path;
                                  project.logoUrl = image?.path ?? project.logoUrl;
                                  cubit.updateLogo(projectId:project.projectId,logoUrl: project.logoUrl);
                                }
                              },
                              child: Badge(
                                isLabelVisible: shared.canEdit(project: project),
                                label: const Icon(Icons.edit,size: 12,color: Colors.white),
                                backgroundColor: AppConstants.mainPurple,
                                alignment: const Alignment(.8, .65),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: shared.handleProfilePage(logoUrl: project.logoUrl,context: context).image
                                ),
                              ),
                            ),
                            const SizedBox(height: 9),
                            // project name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                shared.canEdit(project: project) ? const SizedBox(width: 20) : const SizedBox.shrink(),
                                Text(project.projectName,
                                  style: const TextStyle(
                                    color: AppConstants.mainPurple,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700
                                  )
                                ),
                                shared.canEdit(project: project) == false ? const SizedBox.shrink()
                                : IconButton(
                                  icon: const Icon(Icons.edit,size: 15,color: AppConstants.iconsGrayColor),
                                  onPressed: () => context.push(
                                    screen: EditBaseInfo(project: project),
                                    updateInfo: (p0) {
                                      if (p0 != null) {
                                        homeCubit.refreshHome();
                                      }
                                    }
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 7),
                            // project bootcamp, type, and date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (index) {
                                List titles = [project.bootcampName,project.type,"${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}"];
                                List colors = [0xffff8c2c,0xff01e6d5,0xff4f27b3];
                                List icons = [Icons.lightbulb,Icons.code,Icons.calendar_month_rounded];
                                return ProjectIcon(
                                  title: titles[index],
                                  isVertical: true,
                                  icon: Icon(icons[index],color: Color(colors[index]), size: 18)
                                );
                              })
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Section 2 : Description
                      ViewProjectTitle(project: project,title: 'Description',editable: shared.canEdit(project: project)),
                      Text(
                        project.projectDescription,
                        style: const TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4e4e4e)
                        )
                      ),
                      // Section 3 : Presentation
                      ViewProjectTitle(project: project,title: "Presentation",editable: shared.canEdit(project: project)),
                      InkWell(
                        onTap: () {
                          if (project.presentationUrl.isNotEmpty) {
                            urlLuncher(project.presentationUrl);
                          }
                        },
                        child: const ProjectIcon(
                          isVertical: false,
                          title: "Press to display presentation",
                          icon: Icon(Icons.screenshot_monitor_outlined,color: Color(0xffff8c2c),size: 18),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ProjectIcon(
                        isVertical: false,
                        title: project.endDate,
                        icon: const Icon(Icons.calendar_month_rounded,color: Color(0xff4f27b3),size: 18,),
                      ),
                      // Section 4 : Images
                      ViewProjectTitle(project: project,title: "Images",editable: shared.canEdit(project: project)),
                      ViewProjectImages(images: project.imagesProject),
                      // Section 5 : Members
                      ViewProjectTitle(project: project,title: 'Members',editable: shared.canEdit(project: project)),
                      project.membersProject.isEmpty ? const Text('No Members Added')
                      : Column(
                        children: List.generate(project.membersProject.length, (index) {
                          return ViewProjectMember(
                            member: project.membersProject[index],
                            teamLeadId: project.userId,
                          );
                        }),
                      ),
                      // Section 6 : Rating
                      project.allowRating ? ViewProjectTitle(project: project, title: 'Rating') : const SizedBox.shrink(),
                      project.allowRating == false ? const SizedBox.shrink()
                      : ListTile(
                        onTap: () => context.push(screen: ViewRatingProject(project: project,cubit: homeCubit)),
                        tileColor: Colors.white,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)
                        ),
                        leading: const Icon(Icons.stacked_bar_chart_outlined,color: Colors.green),
                        title: Text(
                          "Rate ${project.projectName}",
                          style: const TextStyle(color: AppConstants.textGrayColor),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: AppConstants.iconsGrayColor),
                      ),
                      // Section 7 : Links 
                      ViewProjectTitle(title: 'Links', project: project, editable: shared.canEdit(project: project),),
                      project.linksProject.isEmpty ? const Text("No Links Added") : ViewProjectLinks(links: project.linksProject),
                      // Section 8 : Settings
                      GetIt.I.get<AuthLayer>().currentUser!.id != project.adminId ? const SizedBox.shrink() : ViewProjectTitle(title: 'Settings',project: project),
                      GetIt.I.get<AuthLayer>().currentUser!.id != project.adminId ? const SizedBox.shrink()
                      : BlocBuilder<v_cubit.ViewProjectCubit, v_cubit.ViewProjectState>(
                          builder: (context, state) {
                            if (state is v_cubit.UpdateRadioButtonState) {
                              if(state.status!=null) {
                                currentState = state.status!;
                              }
                            }
                            if (state is v_cubit.UpdateRadioButtonRating) {
                              if(state.rating!=null) {
                                currentRating = state.rating!;
                              }
                            }
                            if (state is v_cubit.UpdateRadioButtonEditing) {
                              if(state.editing!=null) {
                                currentEditing = state.editing!;
                              }
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Status"),
                                RadioListTile(
                                  value: "Public",
                                  title: const Text("Public"),
                                  groupValue: currentState,
                                  onChanged: (v) {
                                    cubit.setCurrentState(value: v.toString());
                                  },
                                ),
                                RadioListTile(
                                  value: "Private",
                                  title: const Text("Private"),
                                  groupValue: currentState,
                                  onChanged: (v) {
                                    cubit.setCurrentState(value: v.toString());
                                  },
                                ),
                                const Text("Rating"),
                                RadioListTile(
                                  value: "Allow Rating",
                                  title: const Text("Allow Rating"),
                                  groupValue: currentRating,
                                  onChanged: (v) {
                                    cubit.setCurrentRatingState(value: v.toString());
                                  },
                                ),
                                RadioListTile(
                                  value: "Do Not Allow Rating",
                                  title: const Text("Do Not Allow Rating"),
                                  groupValue: currentRating,
                                  onChanged: (v) {
                                    cubit.setCurrentRatingState(value: v.toString());
                                  },
                                ),
                                const Text("Editing"),
                                RadioListTile(
                                  value: "Allow Team Lead to Edit",
                                  title: const Text("Allow Team Lead to Edit"),
                                  groupValue: currentEditing,
                                  onChanged: (v) {
                                    cubit.setCurrentEditingState(value: v.toString());
                                  },
                                ),
                                RadioListTile(
                                  value: "Do Not Allow Team Lead to Edit",
                                  title: const Text("Do Not Allow Team Lead to Edit"),
                                  groupValue: currentEditing,
                                  onChanged: (v) {
                                    cubit.setCurrentEditingState(value: v.toString());
                                  },
                                )
                              ],
                            );
                          }
                        ),
                      // <<<<<<<< to be changed later (NOTICE THIS) >>>>>>>>>>>>
                      GetIt.I.get<AuthLayer>().currentUser!.id != project.adminId ? const SizedBox.shrink()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              cubit.editProjectSettings(
                                projectId: project.projectId,
                                endDate: project.endDate // should change later
                              );
                            },
                            child: const Text("save settings")
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              log(project.projectId);
                              log(GetIt.I.get<AuthLayer>().auth!.token);
                              cubit.deleteProject(projectId: project.projectId);
                            },
                            child: const Text("delete")
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              )
            )
          ),
        );
      }),
    );
  }
}