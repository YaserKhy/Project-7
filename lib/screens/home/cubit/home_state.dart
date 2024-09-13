part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class ShowProjectsState extends HomeState {
  final List<ProjectModel> projects;
  ShowProjectsState({required this.projects});
}