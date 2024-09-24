part of 'shared_cubit.dart';

@immutable
sealed class SharedState {}

final class SharedInitial extends SharedState {}


final class ShowProfileState extends SharedState {
  final ProfileModel? profile;
  ShowProfileState({required this.profile});
}

final class LoadingState extends SharedState {}

final class updateImageState extends SharedState {}

final class ErrorState extends SharedState {
  final String msg;
  ErrorState({required this.msg});
}