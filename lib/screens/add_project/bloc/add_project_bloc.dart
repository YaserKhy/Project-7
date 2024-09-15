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


import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_project_event.dart';
part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  TextEditingController date = TextEditingController();
  bool _allowEditing = false; // Initial value for checkbox

  AddProjectBloc() : super(AddProjectInitial()) {
    on<ChangeEditingValueEvent>((event, emit) {
      _allowEditing = event.value; // Set the value
      emit(ChangeEditingValueState(value: _allowEditing));
    });

    on<ChangeDateEvent>((event, emit) {
      date.text = event.date;
      emit(ChangeDateState());
    });
  }
}
