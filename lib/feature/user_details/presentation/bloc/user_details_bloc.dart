import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/usecase/create_user_usecase.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final CreateUsersDataUsecase createUsersDataUsecase;

  UserDetailsBloc({required this.createUsersDataUsecase})
      : super(UserDetailsInitial()) {
    on<InitUserEvent>((event, emit) {
      nameController.text = event.user.name ?? "";
      roleController.text = event.user.role ?? "";
      dateController.text = event.user.startDate ?? "";
    });

    on<UserDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CreateUserEvent>((event, emit) async {
      var response = await createUsersDataUsecase(CreateUserRequestEntity(
        name: nameController.text,
        role: roleController.text,
        startDate: dateController.text,
      ));
      response.fold((l) {
        //failure state

        emit(CreateErrorState());
      }, (data) {
        //success state

        emit(UserCreatedState());
      });
    });
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    dateController.dispose();
    return super.close();
  }
}
