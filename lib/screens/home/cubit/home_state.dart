part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ShowProjectsState extends HomeState {
  final List<ProjectModel> projects;
  ShowProjectsState({required this.projects});
}

final class LoadingState extends HomeState {}

final class ShowStarsState extends HomeState {}

final class StarChangedState extends HomeState {
  final String field;
  final double newStars;

  StarChangedState({required this.field, required this.newStars});
}

final class ErrorState extends HomeState {
  final String msg;
  ErrorState({required this.msg});
}