import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:project7/constants/app_constants.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/extensions/screen_size.dart';
import 'package:project7/screens/add_project/bloc/add_project_bloc.dart';
import 'package:project7/widgets/buttons/edit_button.dart';

import 'package:project7/widgets/fields/auth_field.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String userId = '';
    String date = '';
    bool allowUserEditing = true;
    return BlocProvider(
      create: (context) => AddProjectBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<AddProjectBloc>();
        return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocListener<AddProjectBloc, AddProjectState>(
              listener: (context, state) {
                if (state is LoadingState) {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()));
                }
                if (state is SuccessState) {
                  Navigator.pop(context);
                  // context.pushReplacement(
                  //     screen: OtpVerificationScreen(
                  //         email: bloc.controllerEmail!.text));
                }
                if (state is ErrorState) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.msg)));
                }
              },
              child: Scaffold(
                backgroundColor: AppConstants.bgColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: context.getWidth(),
                        height: 140,
                        decoration: const BoxDecoration(
                            color: AppConstants.mainPurple,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.arrow_back_ios_new,
                                      color: Colors.white),
                                  onPressed: () => context.pop()),
                              const SizedBox(width: 10),
                              const Text(
                                "Create new project",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontFamily: "Lato"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      Form(
                          key: formKey,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            width: context.getWidth(divideBy: 1.2),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Enter the new project info",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: AppConstants.mainPurple),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  AuthField(
                                    label: "User id :",
                                    validator: (id) {
                                      if (id!.trim().isEmpty) {
                                        return 'User id is required';
                                      }
                                      userId = id;
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  BlocBuilder<AddProjectBloc, AddProjectState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        readOnly: true,
                                        onTap: () => selectDate(context),
                                        decoration: const InputDecoration(
                                          hintStyle:
                                              TextStyle(fontFamily: "Lato"),
                                          labelStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Lato"),
                                          labelText: 'Select Date',
                                          hintText: 'dd/MM/yyyy',
                                          suffixIcon: Icon(
                                            Icons.calendar_today,
                                            color: AppConstants.mainPurple,
                                          ),
                                        ),
                                        controller: TextEditingController(
                                            text: bloc.date.text),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please select a date';
                                          }
                                          date = bloc.date.text;
                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 30),
                                  BlocBuilder<AddProjectBloc, AddProjectState>(
                                    builder: (context, state) {
                                      // Get the current value of allowEditing from the state
                                      bool allowEditing =
                                          state is ChangeEditingValueState
                                              ? state.value
                                              : true;

                                      return CheckboxListTile(
                                        side: const BorderSide(),
                                        activeColor: AppConstants.mainPurple,
                                        title: const Text(
                                          "Allow Editing",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Lato"),
                                        ),
                                        value: allowEditing,
                                        onChanged: (value) {
                                          context.read<AddProjectBloc>().add(
                                              ChangeEditingValueEvent(
                                                  value: value!));
                                          allowUserEditing = value;
                                        },
                                      );
                                    },
                                  ),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "* You can change edit state later",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff9B9B9B)),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  EditButton(
                                    onCancel: () {
                                      context.pop();
                                    },
                                    onSave: () {
                                      if (formKey.currentState!.validate()) {
                                        bloc.add(ValidateFormEvent(
                                            userId: userId,
                                            deadLine: date,
                                            allowEditing: allowUserEditing));
                                      }
                                    },
                                  ),
                                ]),
                          )),
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}

//         AuthButton(
//             title: "Add Project",
//             onPressed: () {
//               if (formKey.currentState!.validate()) {
//                 bloc.add(ValidateFormEvent(
//                     userId: userId,
//                     deadLine: date,
//                     allowEditing: allowUserEditing));
//               }
//             })
//       ],
//     ),
//   ),
// ),

Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(picked);
    context.read<AddProjectBloc>().add(ChangeDateEvent(date: formattedDate));
  }
}
