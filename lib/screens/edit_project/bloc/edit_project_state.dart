part of 'edit_project_bloc.dart';

@immutable
sealed class EditProjectState {}

final class EditProjectInitial extends EditProjectState {}

final class LoadingState extends EditProjectState {}

final class SuccessState extends EditProjectState {}

final class ErrorState extends EditProjectState {
  final String msg;
  ErrorState({required this.msg});
}
