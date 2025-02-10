import 'package:get_it/get_it.dart';
import 'package:product_listing/core/network_repository/network_repository.dart';
import 'package:product_listing/core/network_repository/network_repository_impl.dart';
import 'package:product_listing/feature/home/data/data_source/user_data_source_repository.dart';
import 'package:product_listing/feature/home/data/data_source/user_data_source_repository_impl.dart';
import 'package:product_listing/feature/home/data/repository_impl/users_repository_impl.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';
import 'package:product_listing/feature/home/domain/usecase/get_users_usecase.dart';
import 'package:product_listing/feature/user_details/data/data_source/user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/data_source/user_details_data_source_impl.dart';
import 'package:product_listing/feature/user_details/data/respository_impl/user_details_repository_impl.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';
import 'package:product_listing/feature/user_details/domain/usecase/create_user_usecase.dart';

final sl = GetIt.instance;

injectionContainer() {
  sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());

  sl.registerLazySingleton<UserDataSourceRepository>(
      () => UserDataSourceRepositoryImpl(networkRepository: sl()));
  sl.registerLazySingleton<UserDetailsDataSource>(
      () => UserDetailsDataSourceImpl());

  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(userDataSourceRepository: sl()));
  sl.registerLazySingleton<UserDetailsRepository>(
      () => UserDetailsRepositoryImpl(dataSource: sl()));

  sl.registerLazySingleton(() => GetUsersDataUsecase(sl()));

  sl.registerLazySingleton(() => CreateUsersDataUsecase(sl()));
}
