part of 'view_project_cubit.dart';

@immutable
sealed class ViewProjectState {}

final class ViewProjectInitial extends ViewProjectState {}

final class LoadingState extends ViewProjectState {}

final class ErrorState extends ViewProjectState {
  final String msg;
  ErrorState({required this.msg});
}

final class SuccessState extends ViewProjectState {}