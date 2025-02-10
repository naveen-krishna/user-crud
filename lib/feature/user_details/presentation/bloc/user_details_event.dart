part of 'user_details_bloc.dart';

@immutable
sealed class UserDetailsEvent {}

class InitUserEvent extends UserDetailsEvent {
  final UserEntity user;

  InitUserEvent({required this.user});
}

class CreateUserEvent extends UserDetailsEvent {}

class UpdateUserEvent extends UserDetailsEvent {
  final UserEntity user;

  UpdateUserEvent({required this.user});
}
