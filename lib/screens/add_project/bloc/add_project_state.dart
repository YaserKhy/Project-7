// part of 'add_project_bloc.dart';

// @immutable
// sealed class AddProjectState {}

// final class AddProjectInitial extends AddProjectState {}

// final class ChangeEditingValueState extends AddProjectState {
//   final bool value;
//   ChangeEditingValueState({required this.value});
// }

// final class ChangeDateState extends AddProjectState {}

// final class EnterDateState extends AddProjectState {}

// final class LoadingState extends AddProjectState {}

// final class SuccessState extends AddProjectState {}

// final class ErrorState extends AddProjectState {
//   final String msg;
//   ErrorState({required this.msg});
// }



part of 'add_project_bloc.dart';

@immutable
sealed class AddProjectState {}

final class AddProjectInitial extends AddProjectState {}

final class ChangeEditingValueState extends AddProjectState {
  final bool value;
  ChangeEditingValueState({required this.value});
}

final class ChangeDateState extends AddProjectState {}

final class EnterDateState extends AddProjectState {}

final class LoadingState extends AddProjectState {}

final class SuccessState extends AddProjectState {}

final class ErrorState extends AddProjectState {
  final String msg;
  ErrorState({required this.msg});
}
