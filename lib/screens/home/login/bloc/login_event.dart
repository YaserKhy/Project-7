part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class SubmitLoginEvent extends LoginEvent {
  // final String email;
  // SubmitLoginEvent({required this.email});
}
