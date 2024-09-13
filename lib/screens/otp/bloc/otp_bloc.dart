import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:project7/layers/auth_layer.dart';
import 'package:project7/networking/networking_api.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final api = NetworkingApi();

  OtpBloc() : super(OtpInitial()) {
    on<VerifyEvent>(verifyUser);
  }

  Future<void> verifyUser(VerifyEvent event, Emitter<OtpState> emit) async {
    try {
      emit(LoadingState());
      log("1");
      final userAuth = await api.verifyOTP(email: event.email, otp: event.otp);
      log("2");
      await GetIt.I.get<AuthLayer>().saveAuth(authData: userAuth);
      log("3");
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState());
    }
  }
}
