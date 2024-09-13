import 'dart:async';

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
    on<VerifyEvent>(VerifyUser);
  }

  Future<void> VerifyUser(VerifyEvent event, Emitter<OtpState> emit) async {
    try {
      emit(LoadingState());
      final userAuth = await api.verifyOTP(email: event.email, otp: event.otp);
      await GetIt.I.get<AuthLayer>().saveAuth(authData: userAuth);
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState());
    }
  }
}
