part of 'view_project_cubit.dart';

@immutable
sealed class ViewProjectState {}

final class ViewProjectInitial extends ViewProjectState {}


final class RefreshProjectState extends ViewProjectState {}