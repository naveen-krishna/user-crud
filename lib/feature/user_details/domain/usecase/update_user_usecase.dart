// import 'package:dartz/dartz.dart';
// import 'package:product_listing/core/models/api_failure_model.dart';
// import 'package:product_listing/core/models/no_param_model.dart';
// import 'package:product_listing/core/usecase/usecase.dart';
// import 'package:product_listing/feature/home/domain/entities/user_entity.dart';
// import 'package:product_listing/feature/home/domain/repository/user_repository.dart';
// import 'package:product_listing/feature/user_details/data/data_source/user_details_data_source_repository.dart';

// class UpdateUsersDataUsecase
//     extends Usecase<Either<ApiFailureModel, UserEntity>, NoParamsModel> {
//   final UserDetailsDataSourceRepository userDetailsRepository;

//   UserDetailsDataSourceRepository(this.userDetailsRepository);
//   @override
//   Future<Either<ApiFailureModel, UserEntity>> call(
//           NoParamsModel params) async =>
//       userDetailsRepository.updateUser(params: params);
// }
