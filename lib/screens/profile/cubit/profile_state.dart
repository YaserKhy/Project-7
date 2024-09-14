part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ShowProfileState extends ProfileState {
  final ProfileModel profile;
  ShowProfileState({required this.profile});
}