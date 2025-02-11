import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source.dart';
import 'package:product_listing/feature/user_details/data/data_source/firebase_user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';
import 'package:product_listing/feature/user_details/data/models/update_user_request_model.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/entity/update_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';

class UserDetailsRepositoryImpl extends UserDetailsRepository {
  final FirebaseUserDetailsDataSource dataSource;
  final LocalUserDataSource localDataSource;

  UserDetailsRepositoryImpl({
    required this.dataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<ApiFailureModel, bool>> createUser(
          {required CreateUserRequestEntity params}) =>
      baseMethodExceptions(() => createUserApi(params: params));

  Future<Either<ApiFailureModel, bool>> createUserApi(
      {required CreateUserRequestEntity params}) async {
    CreateUserRequestModel createUserRequestModel = CreateUserRequestModel();

    final result =
        await dataSource.createUser(params: createUserRequestModel(params));

    await localDataSource.clearUsers(params: NoParamsModel());

    return Right(result);
  }

  @override
  Future<Either<ApiFailureModel, bool>> updateUser(
          {required UpdateUserRequestEntity params}) =>
      baseMethodExceptions(() => updateUserApi(params: params));

  Future<Either<ApiFailureModel, bool>> updateUserApi(
      {required UpdateUserRequestEntity params}) async {
    UpdateUserRequestModel updateUserRequestModel = UpdateUserRequestModel();

    final result =
        await dataSource.updateUser(params: updateUserRequestModel(params));

    await localDataSource.clearUsers(params: NoParamsModel());

    return Right(result);
  }
}
