import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/firebase_user_data_source.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source.dart';
import 'package:product_listing/feature/home/data/models/delete_user_request_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';
import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseUserDataSource firebaseUserDataSource;
  final LocalUserDataSource localUserDataSource;

  UserRepositoryImpl({
    required this.firebaseUserDataSource,
    required this.localUserDataSource,
  });

  @override
  Future<Either<ApiFailureModel, List<UserEntity>>> getUserList(
          {required NoParamsModel params}) =>
      baseMethodExceptions(() => getUserListApi(params: params));

  Future<Either<ApiFailureModel, List<UserEntity>>> getUserListApi(
      {required NoParamsModel params}) async {
    List<UserEntity> userListEntity = [];

    List<UserModel> userModelList = [];

    userModelList = await localUserDataSource.getUserList(params: params);

    if (userModelList.isNotEmpty) {
      userListEntity = userModelList.map((model) {
        UserEntity entity = UserEntity();
        return entity(model);
      }).toList();

      return Right(userListEntity);
    }
    userModelList = await firebaseUserDataSource.getUserList(params: params);
    if (userModelList.isEmpty) {
      await localUserDataSource.cacheUsers(users: userModelList);

      userListEntity = userModelList.map((model) {
        UserEntity entity = UserEntity();
        return entity(model);
      }).toList();
    }
    return Right(userListEntity);
  }

  @override
  Future<Either<ApiFailureModel, bool>> deleteUser(
          {required DeleteUserRequestEntity params}) =>
      baseMethodExceptions(() => deleteUserApi(params: params));

  Future<Either<ApiFailureModel, bool>> deleteUserApi(
      {required DeleteUserRequestEntity params}) async {
    DeleteUserRequestModel deleteUserRequestModel = DeleteUserRequestModel();
    return Right(await firebaseUserDataSource.deleteUser(
        params: deleteUserRequestModel(params)));
  }
}
