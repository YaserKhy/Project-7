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
import 'package:project7/screens/view_project/cubit/view_project_cubit.dart'
    as v_cubit;
import 'package:project7/screens/view_project/view_project_images.dart';
import 'package:project7/screens/view_project/view_project_links.dart';
import 'package:project7/screens/view_project/view_project_member.dart';
import 'package:project7/screens/view_project/view_project_title.dart';
import 'package:project7/screens/view_project/view_rating_project.dart';
import 'package:project7/widgets/dropdowns/status_drop_down.dart';
import 'package:project7/widgets/icons/project_icon.dart';

class ProjectScreen extends StatelessWidget {
  final HomeCubit homeCubit;
  final ProjectModel project;
  const ProjectScreen(
      {super.key, required this.project, required this.homeCubit});
  @override
  Widget build(BuildContext context) {
    File? image;
    String? imgPath = project.logoUrl;
    final shared = context.read<SharedCubit>();
    TextEditingController statusController =
        TextEditingController(text: project.isPublic ? "Public" : "Private");
    return BlocProvider(
      create: (context) => v_cubit.ViewProjectCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<v_cubit.ViewProjectCubit>();
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            }
            if (state is v_cubit.SuccessState) {
              context.popAndSave();
              context.popAndSave();
            }
          },
          child: Scaffold(
              backgroundColor: AppConstants.bgColor,
              appBar: AppBar(backgroundColor: AppConstants.bgColor),
              body: SafeArea(
                  child: SingleChildScrollView(
                      child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            onTap: shared.canEdit(project: project)==false ? null : () async {
                              final selectedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (selectedImage != null) {
                                image = File(selectedImage.path);
                                imgPath = image!.path;
                                project.logoUrl =
                                    image?.path ?? project.logoUrl;
                                    cubit.updateLogo(projectId:project.projectId,logoUrl: project.logoUrl);
                              }
                            },
                            child: Badge(
                              isLabelVisible: shared.canEdit(project: project),
                              label: const Icon(
                                Icons.edit,
                                size: 12,
                                color: Colors.white,
                              ),
                              backgroundColor: AppConstants.mainPurple,
                              alignment: const Alignment(.8, .65),
                              child: CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: shared
                                      .handleProfilePage(
                                          logoUrl: project.logoUrl,
                                          context: context)
                                      .image),
                            ),
                          ),
                          const SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              shared.canEdit(project: project)
                                  ? const SizedBox(width: 20)
                                  : const SizedBox.shrink(),
                              Text(project.projectName,
                                  style: const TextStyle(
                                      color: AppConstants.mainPurple,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700)),
                              shared.canEdit(project: project) == false
                                  ? const SizedBox.shrink()
                                  : IconButton(
                                      onPressed: () => context.push(
                                          screen:
                                              EditBaseInfo(project: project),
                                              updateInfo: (p0) {
                                              if (p0 != null) {
                                                homeCubit.refreshHome();
                                              }
                                            },),
                                      icon: const Icon(
                                        Icons.edit,
                                        size: 15,
                                        color: AppConstants.iconsGrayColor,
                                      ))
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(3, (index) {
                                List titles = [
                                  project.bootcampName,
                                  project.type,
                                  "${project.endDate.substring(2, 4)}/${project.endDate.substring(5, 7)}"
                                ];
                                List colors = [
                                  0xffff8c2c,
                                  0xff01e6d5,
                                  0xff4f27b3
                                ];
                                List icons = [
                                  Icons.lightbulb,
                                  Icons.code,
                                  Icons.calendar_month_rounded
                                ];
                                return ProjectIcon(
                                    title: titles[index],
                                    isVertical: true,
                                    icon: Icon(icons[index],
                                        color: Color(colors[index]), size: 18));
                              })),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    ViewProjectTitle(
                        project: project,
                        title: 'Description',
                        editable: shared.canEdit(project: project)),
                    Text(project.projectDescription,
                        style: const TextStyle(
                            fontFamily: "Lato",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4e4e4e))),
                    ViewProjectTitle(
                        project: project,
                        title: "Presentation",
                        editable: shared.canEdit(project: project)),
                    InkWell(
                      onTap: () {
                        if (project.presentationUrl.isNotEmpty) {
                          urlLuncher(project.presentationUrl);
                        }
                      },
                      child: const ProjectIcon(
                          title: "Press to display presentation",
                          icon: Icon(
                            Icons.screenshot_monitor_outlined,
                            color: Color(0xffff8c2c),
                            size: 18,
                          ),
                          isVertical: false),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ProjectIcon(
                      title: project.endDate,
                      isVertical: false,
                      icon: const Icon(
                        Icons.calendar_month_rounded,
                        color: Color(0xff4f27b3),
                        size: 18,
                      ),
                    ),
                    ViewProjectTitle(
                        project: project,
                        title: "Images",
                        editable: shared.canEdit(project: project)),
                    ViewProjectImages(
                        images: project.imagesProject),
                    ViewProjectTitle(
                        project: project,
                        title: 'Members',
                        editable: shared.canEdit(project: project)),
                    project.membersProject.isEmpty
                        ? const Text('No Members Added')
                        : Column(
                            children: List.generate(
                                project.membersProject.length, (index) {
                              return ViewProjectMember(
                                  member: project.membersProject[index],
                                  teamLeadId: project.userId,
                                );
                            }),
                          ),
                    project.allowRating
                        ? ViewProjectTitle(project: project, title: 'Rating')
                        : const SizedBox.shrink(),
                    project.allowRating == false
                        ? const SizedBox.shrink()
                        : ListTile(
                            onTap: () => context.push(
                                screen: ViewRatingProject(
                              project: project,
                              cubit: homeCubit,
                            )),
                            tileColor: Colors.white,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)),
                            leading: const Icon(
                                Icons.stacked_bar_chart_outlined,
                                color: Colors.green),
                            title: Text(
                              "Rate ${project.projectName}",
                              style: const TextStyle(
                                  color: AppConstants.textGrayColor),
                            ),
                            trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: AppConstants.iconsGrayColor),
                          ),
                    ViewProjectTitle(title: 'Links', project: project),
                    project.linksProject.isEmpty
                        ? const Text("No Links Added")
                        : ViewProjectLinks(links: project.linksProject),
                    shared.isUser()
                        ? const SizedBox.shrink()
                        : ViewProjectTitle(
                            title: 'Settings',
                            project: project,
                          ),
                    shared.isUser()
                        ? const SizedBox.shrink()
                        : StatusDropDown(controller: statusController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              final api = NetworkingApi();
                              await api.editProjectStatus(
                                  token: GetIt.I.get<AuthLayer>().auth!.token,
                                  projectId: project.projectId,
                                  endDate: project.endDate,
                                  isEditable: project.allowEdit,
                                  isRatable: project.allowRating,
                                  isPublic: statusController.text == 'Public'
                                      ? true
                                      : false);
                            },
                            child: const Text("data")),
                        ElevatedButton(
                            onPressed: () async {
                              final api = NetworkingApi();
                              log(project.projectId);
                              log(GetIt.I.get<AuthLayer>().auth!.token);
                              await api.deleteProject(
                                  projectId: project.projectId,
                                  token: GetIt.I.get<AuthLayer>().auth!.token);
                            },
                            child: const Text("delete")),
                      ],
                    ),
                  ],
                ),
              )))),
        );
      }),
    );
  }
}
