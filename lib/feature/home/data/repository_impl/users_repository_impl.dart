import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/user_data_source.dart';
import 'package:product_listing/feature/home/data/models/delete_user_request_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserDataSource userDataSourceRepository;

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

  @override
  Future<Either<ApiFailureModel, bool>> deleteUser({required params}) =>
      baseMethodExceptions(() => deleteUserApi(params: params));

  Future<Either<ApiFailureModel, bool>> deleteUserApi(
      {required DeleteUserRequestEntity params}) async {
    DeleteUserRequestModel deleteUserRequestModel = DeleteUserRequestModel();
    return Right(await userDataSourceRepository.deleteUser(
        params: deleteUserRequestModel(params)));
  }
}
