import 'package:dartz/dartz.dart';
import 'package:product_listing/core/base/base_exception.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/entity/update_user_request_entity.dart';

abstract class UserDetailsRepository extends BaseException {
  Future<Either<ApiFailureModel, bool>> createUser(
      {required CreateUserRequestEntity params});
  Future<Either<ApiFailureModel, bool>> updateUser(
      {required UpdateUserRequestEntity params});
}
