part of 'page_cubit.dart';

@immutable
sealed class PageState {}

final class PageInitial extends PageState {}

final class SwitchScreenState extends PageState {}