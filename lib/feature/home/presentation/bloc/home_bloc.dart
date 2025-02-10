import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/usecase/delete_user_usecase.dart';
import 'package:product_listing/feature/home/domain/usecase/get_users_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUsersDataUsecase getUsersDataUsecase;

  final DeleteUserDataUsecase deleteUserDataUsecase;

  List<ProductEntity>? products;

  TextEditingController searchController = TextEditingController();
  HomeBloc({
    required this.getUsersDataUsecase,
    required this.deleteUserDataUsecase,
  }) : super(InitialState()) {
    on<FetchUsersEvent>((event, emitState) async {
      emitState(LoadingState());
      var users = await getUsersDataUsecase(NoParamsModel());
      users.fold((failure) {
        emitState(FetchErrorState(apiFailureModel: failure));
      }, (data) {
        emitState(FetchUsersState(users: data));
      });
    });

    on<DeleteUserEvent>((event, emit) async {
      var response = await deleteUserDataUsecase(DeleteUserRequestEntity(
        id: event.userId,
      ));
      response.fold((l) {
        //failure state

        emit(DeleteErrorState());
      }, (data) {
        //success state

        emit(UserDeletedState());
      });
    });
  }
}
