part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}
final class SuccessState extends OtpState {}
final class LoadingState extends OtpState {}
final class ErrorState extends OtpState {}
