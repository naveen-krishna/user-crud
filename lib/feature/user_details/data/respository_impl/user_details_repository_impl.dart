import 'package:dartz/dartz.dart';
import 'package:product_listing/core/models/api_failure_model.dart';
import 'package:product_listing/feature/user_details/data/data_source/user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';

class UserDetailsRepositoryImpl extends UserDetailsRepository {
  final UserDetailsDataSource dataSource;

  UserDetailsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ApiFailureModel, bool>> createUser(
          {required CreateUserRequestEntity params}) =>
      baseMethodExceptions(() => createUserApi(params: params));

  Future<Either<ApiFailureModel, bool>> createUserApi(
      {required CreateUserRequestEntity params}) async {
    CreateUserRequestModel createUserRequestModel = CreateUserRequestModel();
    return Right(
        await dataSource.createUser(params: createUserRequestModel(params)));
  }
}
