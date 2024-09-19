import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:project7/networking/networking_api.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  TextEditingController? controllerEmail =
      TextEditingController(text: "turkial3oofi@gmail.com");
  NetworkingApi api = NetworkingApi();
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLoginEvent>(login);
  }

  Future<void> login(SubmitLoginEvent event, Emitter<LoginState> emit) async {
    try {
      emit(LoadingState());
      log("message 1");
      await api.sendOtp(email: controllerEmail!.text);
      log("message 2");
      emit(SuccessState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (error) {
      emit(ErrorState(msg: "There is error with code 194FR94"));
    }
  }
}
