part of 'add_project_bloc.dart';

@immutable
sealed class AddProjectEvent {}

final class ChangeEditingValueEvent extends AddProjectEvent {
  final bool value;
  ChangeEditingValueEvent({required this.value});
}
final class ChangeDateEvent extends AddProjectEvent {
  final String date;
  ChangeDateEvent({required this.date});
}

final class ValidateFormEvent extends AddProjectEvent {}

