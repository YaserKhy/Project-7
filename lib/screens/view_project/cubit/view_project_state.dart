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

final class UpdateRadioButtonState extends ViewProjectState {
  final String? status;
  UpdateRadioButtonState({required this.status});
}
final class UpdateRadioButtonRating extends ViewProjectState {
  final String? rating;
  UpdateRadioButtonRating({required this.rating});
}
final class UpdateRadioButtonEditing extends ViewProjectState {
  final String? editing;
  UpdateRadioButtonEditing({required this.editing});
}

final class ShowStarsState extends ViewProjectState {}

final class StarChangedState extends ViewProjectState {
  final String field;
  final double newStars;

  StarChangedState({required this.field, required this.newStars});
}