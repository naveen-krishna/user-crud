part of 'home_bloc.dart';

sealed class HomeEvent {}

class FetchUsersEvent extends HomeEvent {}

class DeleteUserEvent extends HomeEvent {
  final String userId;

  DeleteUserEvent({required this.userId});
}
