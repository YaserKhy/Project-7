import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/data_layers/auth_layer.dart';
import 'package:project7/models/profile_model.dart';
import 'package:project7/models/project_model.dart';
import 'package:project7/networking/networking_api.dart';
import 'package:project7/screens/edit_project/bloc/edit_project_bloc.dart';
import 'package:project7/widgets/buttons/edit_button.dart';
import 'package:project7/widgets/dialogs/warning_dialog.dart';
import 'package:project7/widgets/fields/date_field.dart';
import 'package:project7/widgets/fields/drop_down.dart';
import 'package:project7/widgets/fields/edit_field.dart';
import 'package:project7/widgets/texts/profile_title.dart';

class EditBaseInfo extends StatelessWidget {
  final ProjectModel project;
  const EditBaseInfo({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bootcampController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController presentationDateController = TextEditingController();
    nameController.text = project.projectName;
    bootcampController.text = project.bootcampName;
    typeController.text = project.type;
    descriptionController.text = project.projectDescription;
    startDateController.text = project.startDate ?? "15/12/2024";
    endDateController.text = project.endDate;
    presentationDateController.text = project.presentationDate ?? "15/12/2024";
    return BlocProvider(
      create: (context) => EditProjectBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<EditProjectBloc>();
        return BlocListener<EditProjectBloc, EditProjectState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Center(child: CircularProgressIndicator())
              );
            }
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppConstants.bgColor,
              appBar: AppBar(
                centerTitle: true,
                forceMaterialTransparency: true,
                title: const Text(
                  "Edit Project",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppConstants.mainPurple,
                    fontSize: 24,
                    fontFamily: "Lato"
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Divider(),
                      const SizedBox(height: 10),
                      EditField(lebal: "Project name",controller: nameController,),
                      EditField(lebal: "Bootcamp",controller: bootcampController,),
                      DropDown(controller: typeController),
                      const SizedBox(height: 10),
                      EditField(
                        controller: descriptionController,
                        lebal: "project Description",
                        minHeight: 300,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 20),
                      const ProfileTitle(title: "Dates"),
                      const Divider(),
                      const SizedBox(height: 10),
                      DateField(
                        label: "Start Date",
                        controller: startDateController,
                        selectDate: (BuildContext context) async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
                            startDateController.text = formattedDate;
                          }
                        },
                      ),
                      DateField(
                        label: "End Date",
                        controller: endDateController,
                        selectDate: (BuildContext context) async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
                            endDateController.text = formattedDate;
                          }
                        },
                      ),
                      DateField(
                        label: "Presentation Date",
                        controller: presentationDateController,
                        selectDate: (BuildContext context) async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (picked != null) {
                            final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
                            presentationDateController.text = formattedDate;
                          }
                        },
                      ),
                      EditButton(
                        onCancel: () {
                          warningDialog(context: context);
                          context.pop();
                        },
                        onSave: () async {
                          log(nameController.text);
                          log('before ADD : ${GetIt.I.get<AuthLayer>().currentUser!.projects.map((p)=>p.projectName).toList().toString()}');
                          bloc.add(ModifyProjectEvent(
                            token: GetIt.I.get<AuthLayer>().auth!.token,
                            id: project.projectId,
                            name: nameController.text,
                            bootcamp: bootcampController.text,
                            type: typeController.text,
                            description: descriptionController.text,
                            startDate: startDateController.text,
                            endDate: endDateController.text,
                            presentationDate: presentationDateController.text
                          ));
                          log('AFTER ADD : ${GetIt.I.get<AuthLayer>().currentUser!.projects.map((p)=>p.projectName).toList().toString()}');
                          final api = NetworkingApi();
                          ProfileModel temp = await api.getProfile(token: GetIt.I.get<AuthLayer>().auth!.token);
                          log('AFTER ADD 2 : ${temp.projects.map((p)=>p.projectName).toList().toString()}');
                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
        );
      }),
    );
  }
}

//app, website, vr, ar, ai, ml, ui/ux, gaming, unity, cyber, software, automation, robotic, api, analytics, iot, cloud
Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
    // context.read<AddProjectBloc>().add(ChangeDateEvent(date: formattedDate));
  }
}