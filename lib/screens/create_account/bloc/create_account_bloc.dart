import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:project7/networking/networking_api.dart';
part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
  TextEditingController? controllerEmail =
      TextEditingController(text: "racopo4120@cetnob.com");
  TextEditingController? controllerFName = TextEditingController(text: "ali");
  TextEditingController? controllerLName = TextEditingController(text: "fahad");
  final api = NetworkingApi();

  CreateAccountBloc() : super(CreateAccountInitial()) {
    on<CreateEvent>(createMethod);
  }

  FutureOr<void> createMethod(
      CreateEvent event, Emitter<CreateAccountState> emit) async {
    try {
      emit(LoadingState());
      print("emailCreate");

      final emailCreate = await api.createNewAccount(
          email: controllerEmail!.text,
          firstName: controllerFName!.text,
          lastName: controllerLName!.text);
      print(emailCreate);
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }
}
