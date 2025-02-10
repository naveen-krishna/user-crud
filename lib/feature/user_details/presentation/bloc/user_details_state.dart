part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsState {}

final class UserDetailsInitial extends UserDetailsState {}

class LoadingState extends UserDetailsState {}

class UserCreatedState extends UserDetailsState {}

class UserUpdatedState extends UserDetailsState {
  final List<UserEntity>? users;
  UserUpdatedState({required this.users});
}

class CreateErrorState extends UserDetailsState {}

class UpdateErrorState extends UserDetailsState {
  final ApiFailureModel apiFailureModel;

  UpdateErrorState({required this.apiFailureModel});
}
