import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/usecase/usecase.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';

class CreateUsersDataUsecase
    extends Usecase<Either<ApiFailureModel, bool>, CreateUserRequestEntity> {
  final UserDetailsRepository userDetailsRepository;

  CreateUsersDataUsecase(this.userDetailsRepository);
  @override
  Future<Either<ApiFailureModel, bool>> call(
          CreateUserRequestEntity params) async =>
      userDetailsRepository.createUser(params: params);
}
