part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

class LoadingState extends UserDetailsState {}

class UserCreatedState extends UserDetailsState {}

class UserUpdatedState extends UserDetailsState {}

class CreateErrorState extends UserDetailsState {}

class UpdateErrorState extends UserDetailsState {}
