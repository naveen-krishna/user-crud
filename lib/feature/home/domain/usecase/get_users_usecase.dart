import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/core/usecase/usecase.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';

class GetUsersDataUsecase
    extends Usecase<Either<ApiFailureModel, List<UserEntity>>, NoParamsModel> {
  final UserRepository userRepository;

  GetUsersDataUsecase(this.userRepository);
  @override
  Future<Either<ApiFailureModel, List<UserEntity>>> call(
          NoParamsModel params) async =>
      userRepository.getUserList(params: params);
}
