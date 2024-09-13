part of 'create_account_bloc.dart';

@immutable
sealed class CreateAccountState {}

final class CreateAccountInitial extends CreateAccountState {}

final class LoadingState extends CreateAccountState {}

final class SuccessState extends CreateAccountState {}

final class ErrorState extends CreateAccountState {
  final String msg;
  ErrorState({required this.msg});
}
