part of 'my_projects_cubit.dart';

@immutable
sealed class MyProjectsState {}

final class MyProjectsInitial extends MyProjectsState {}

final class ShowMyProjectsState extends MyProjectsState {
  final List<ProjectModel> myProjects;
  ShowMyProjectsState({required this.myProjects});
}

final class LoadingState extends MyProjectsState {}

final class ErrorState extends MyProjectsState {
  final String msg;
  ErrorState({required this.msg});
}