// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';

// part 'add_project_event.dart';
// part 'add_project_state.dart';

// class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
//   TextEditingController date = TextEditingController();
//   AddProjectBloc() : super(AddProjectInitial()) {
//     on<ChangeEditingValueEvent>((event, emit) {
//       log(event.value.toString());
//       emit(ChangeEditingValueState(value: !event.value));
//     });
//     on<ChangeDateEvent>((event, emit) {
//       date.text = event.date;
//       emit(ChangeDateState());
//     });
//   }
// }

import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project7/networking/networking_api.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  TextEditingController date = TextEditingController();
  bool _allowEditing = true; // Initial value for checkbox
  NetworkingApi api = NetworkingApi();

  AddProjectBloc() : super(AddProjectInitial()) {
    on<ChangeEditingValueEvent>(ChangeEditingValue);
    on<ChangeDateEvent>(changeDate);

    on<ValidateFormEvent>(ValidateForm);
  }

  FutureOr<void> changeDate(
      ChangeDateEvent event, Emitter<AddProjectState> emit) {
    date.text = event.date;
    emit(ChangeDateState());
  }

  FutureOr<void> ChangeEditingValue(
      ChangeEditingValueEvent event, Emitter<AddProjectState> emit) {
    _allowEditing = event.value; // Set the value
    emit(ChangeEditingValueState(value: _allowEditing));
  }
  Future<void> ValidateForm(
      ValidateFormEvent event, Emitter<AddProjectState> emit) async {
        try{
              emit(LoadingState());
      await api.createProject(userId: event.userId, deadline: event.deadLine, allowEditing: event.allowEditing);
    emit(SuccessState());
        }on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }
}
