import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'view_project_state.dart';


class ViewProjectCubit extends Cubit<ViewProjectState> {
  ViewProjectCubit() : super(ViewProjectInitial());

  TextEditingController commentController = TextEditingController();
  // ViewProjectCubit() : super("Private"); // Initial state is "Private"

  // void selectItem(String item) {
  //   emit(item);
  // }

  refreshProject() {
    emit(RefreshProjectState());
  }
}
