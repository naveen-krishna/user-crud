part of 'home_bloc.dart';

sealed class HomeState {}

class InitialState extends HomeState {}

class FetchUsersState extends HomeState {
  List<UserEntity>? users;
  FetchUsersState({required this.users});
}

class LoadingState extends HomeState {}

class UserDeletedState extends HomeState {}

class DeleteErrorState extends HomeState {}

class FetchErrorState extends HomeState {
  final ApiFailureModel apiFailureModel;

  FetchErrorState({required this.apiFailureModel});
}
