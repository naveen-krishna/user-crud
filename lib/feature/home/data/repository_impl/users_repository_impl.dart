import 'package:dartz/dartz.dart';
import 'package:product_listing/core/base/base_exception.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/user_data_source_repository.dart';
import 'package:product_listing/feature/home/data/models/product_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';
import 'package:product_listing/feature/home/domain/entities/product_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSourceRepository userDataSourceRepository;

  UserRepositoryImpl({required this.userDataSourceRepository});

  @override
  Future<Either<ApiFailureModel, List<UserEntity>>> getUserList(
          {required NoParamsModel params}) =>
      baseMethodExceptions(() => getProductListApi(params: params));

  Future<Either<ApiFailureModel, List<UserEntity>>> getProductListApi(
      {required NoParamsModel params}) async {
    List<UserEntity> userListEntity;

    List<UserModel> userListModel =
        await userDataSourceRepository.getUserList(params: params);

    userListEntity = userListModel.map((model) {
      UserEntity entity = UserEntity();
      return entity(model);
    }).toList();

    return Right(userListEntity);
  }

  // @override
  // Future<Either<ApiFailureModel, String>> createUser(
  //     {required NoParamsModel params}) async {
  //   final result = await userDataSourceRepository.createUser(params: params);

  //   return Right(result);
  // }

  // @override
  // Future<Either<ApiFailureModel, bool>> deleteUser(
  //     {required NoParamsModel params}) async {
  //   bool result = await userDataSourceRepository.deleteUser(params: params);

  //   return Right(result);
  // }

  // @override
  // Future<Either<ApiFailureModel, UserEntity>> updateUser(
  //     {required NoParamsModel params}) async {
  //   final userModel =
  //       await userDataSourceRepository.updateUser(params: params);

  //   UserEntity entity = UserEntity();
  //   entity(userModel);

  //   return Right(entity);
  // }
}
