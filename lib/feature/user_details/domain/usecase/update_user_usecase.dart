import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/usecase/usecase.dart';
import 'package:product_listing/feature/user_details/domain/entity/update_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';

class UpdateUsersDataUsecase
    extends Usecase<Either<ApiFailureModel, bool>, UpdateUserRequestEntity> {
  final UserDetailsRepository userDetailsRepository;

  UpdateUsersDataUsecase(this.userDetailsRepository);
  @override
  Future<Either<ApiFailureModel, bool>> call(
          UpdateUserRequestEntity params) async =>
      userDetailsRepository.updateUser(params: params);
}
