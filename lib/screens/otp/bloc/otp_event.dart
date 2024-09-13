part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

final class VerifyEvent extends OtpEvent {
  final String email;
  final String otp;
  VerifyEvent({required this.email,required this.otp});
}
