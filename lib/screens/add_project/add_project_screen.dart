import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project7/extensions/screen_navigation.dart';
import 'package:project7/screens/add_project/bloc/add_project_bloc.dart';
import 'package:project7/widgets/buttons/auth_button.dart';
import 'package:project7/widgets/fields/auth_field.dart';
import 'package:intl/intl.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AddProjectBloc>();
    final formKey = GlobalKey<FormState>();
    String userId = '';
    String date = '';
    bool allowUserEditing = true;

    // bool allowEditing = true;
    // String _selectedDate = '';
    // String _dateCount = '';
    // String _range = '';
    // String _rangeCount = '';

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
                body: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Add new project"),
                      AuthField(
                        label: "User id",
                        validator: (id) {
                          if (id!.trim().isEmpty) {
                            return 'User id is required';
                          }
                          userId = id;
                          return null;
                        },
                      ),
                      BlocBuilder<AddProjectBloc, AddProjectState>(
                        builder: (context, state) {
                          return TextFormField(
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            decoration: const InputDecoration(
                              labelText: 'Select Date',
                              hintText: 'dd/MM/yyyy',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            controller:
                                TextEditingController(text: bloc.date.text),
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
                      BlocBuilder<AddProjectBloc, AddProjectState>(
                        builder: (context, state) {
                          // Get the current value of allowEditing from the state
                          bool allowEditing = state is ChangeEditingValueState
                              ? state.value
                              : true;

                          return CheckboxListTile(
                            title: const Text("Allow Editing"),
                            value: allowEditing,
                            onChanged: (value) {
                              context
                                  .read<AddProjectBloc>()
                                  .add(ChangeEditingValueEvent(value: value!));
                              allowUserEditing = value;
                            },
                          );
                        },
                      ),
                      AuthButton(
                          title: "Add Project",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              bloc.add(ValidateFormEvent(userId: userId, deadLine: date, allowEditing: allowUserEditing));
                            }
                          })
                    ],
                  ),
                ),
              ),
            ))));
  }
}

Future<void> _selectDate(BuildContext context) async {
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
