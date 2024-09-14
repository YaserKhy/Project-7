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
    on<ResendOtpEvent>(resendOtp);
  }

  Future<void> verifyUser(VerifyEvent event, Emitter<OtpState> emit) async {
    try {
      emit(LoadingState());
      final userAuth = await api.verifyOTP(email: event.email, otp: event.otp);
      await GetIt.I.get<AuthLayer>().saveAuth(authData: userAuth);
      emit(SuccessState());
    } catch (_) {
      emit(ErrorState(msg: "There is error with verification"));
    }
  }

  Future<void> resendOtp(ResendOtpEvent event, Emitter<OtpState> emit) async {
    try {
      emit(LoadingState());
      log("message 1");
      await api.sendOtp(email: event.email);
      log("message 2");
      emit(ResendedState());
    } on FormatException catch (error) {
      emit(ErrorState(msg: error.message));
    } catch (_) {
      emit(ErrorState(msg: "There is error with resending otp"));
    }
  }
}
