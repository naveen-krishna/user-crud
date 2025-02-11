import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/entity/update_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/usecase/create_user_usecase.dart';
import 'package:product_listing/feature/user_details/domain/usecase/update_user_usecase.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final CreateUsersDataUsecase createUsersDataUsecase;
  final UpdateUsersDataUsecase updateUsersDataUsecase;

  UserDetailsBloc({
    required this.createUsersDataUsecase,
    required this.updateUsersDataUsecase,
  }) : super(UserDetailsInitial()) {
    on<InitUserEvent>((event, emit) {
      nameController.text = event.user.name ?? "";
      roleController.text = event.user.role ?? "";
      startDateController.text = event.user.startDate ?? "";
      endDateController.text = event.user.endDate ?? "";
    });

    on<CreateUserEvent>((event, emit) async {
      var response = await createUsersDataUsecase(CreateUserRequestEntity(
        name: nameController.text,
        role: roleController.text,
        startDate: _setStartDate(),
        endDate: endDateController.text,
      ));
      response.fold((l) {
        //failure state
        emit(CreateErrorState());
      }, (data) {
        //success state

        emit(UserCreatedState());
      });
    });

    on<UpdateUserEvent>((event, emit) async {
      var response = await updateUsersDataUsecase(UpdateUserRequestEntity(
        id: event.userId,
        name: nameController.text,
        role: roleController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
      ));
      response.fold((l) {
        //failure state

        emit(UpdateErrorState());
      }, (data) {
        //success state

        emit(UserUpdatedState());
      });
    });
  }

  String _setStartDate() {
    return startDateController.text.isEmpty
        ? DateFormat("d MMM yyyy").format(DateTime.now())
        : startDateController.text;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    roleController.dispose();
    startDateController.dispose();
    endDateController.dispose();

    return super.close();
  }
}
