import 'package:dartz/dartz.dart';
import 'package:product_listing/core/base/base_exception.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';

abstract class UserRepository extends BaseException {
  Future<Either<ApiFailureModel, List<UserEntity>>> getUserList(
      {required NoParamsModel params});

  Future<Either<ApiFailureModel, bool>> deleteUser(
      {required DeleteUserRequestEntity params});
}
