part of 'edit_project_bloc.dart';

@immutable
sealed class EditProjectEvent {}

final class ModifyProjectEvent extends EditProjectEvent {
  final String token;
  final String id;
  final String name;
  final String bootcamp;
  final String type;
  final String description;
  final String startDate;
  final String endDate;
  final String presentationDate;
  ModifyProjectEvent({
    required this.id,
    required this.name,
    required this.bootcamp,
    required this.type,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.presentationDate,
    required this.token,
  });
}
