part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ShowProjectsState extends HomeState {
  final List<ProjectModel> projects;
  ShowProjectsState({required this.projects});
}

final class ShowBottomSheetState extends HomeState {
  final double newStars;
  ShowBottomSheetState({required this.newStars});
}

final class LoadingState extends HomeState {}

final class ErrorState extends HomeState {
  final String msg;
  ErrorState({required this.msg});
}
