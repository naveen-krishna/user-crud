import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/usecase/usecase.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';

class DeleteUserDataUsecase
    extends Usecase<Either<ApiFailureModel, bool>, DeleteUserRequestEntity> {
  final UserRepository userRepository;

  DeleteUserDataUsecase(this.userRepository);
  @override
  Future<Either<ApiFailureModel, bool>> call(
          DeleteUserRequestEntity params) async =>
      userRepository.deleteUser(params: params);
}
