import 'package:get_it/get_it.dart';
import 'package:product_listing/feature/home/data/data_source/firebase_user_data_source.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source_impl.dart';
import 'package:product_listing/feature/home/data/data_source/firebase_user_data_source_impl.dart';
import 'package:product_listing/feature/home/data/repository_impl/users_repository_impl.dart';
import 'package:product_listing/feature/home/domain/repository/user_repository.dart';
import 'package:product_listing/feature/home/domain/usecase/delete_user_usecase.dart';
import 'package:product_listing/feature/home/domain/usecase/get_users_usecase.dart';
import 'package:product_listing/feature/user_details/data/data_source/firebase_user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/data_source/firebase_user_details_data_source_impl.dart';
import 'package:product_listing/feature/user_details/data/respository_impl/user_details_repository_impl.dart';
import 'package:product_listing/feature/user_details/domain/repository/user_details_repository.dart';
import 'package:product_listing/feature/user_details/domain/usecase/create_user_usecase.dart';
import 'package:product_listing/feature/user_details/domain/usecase/update_user_usecase.dart';

final sl = GetIt.instance;

injectionContainer() {
  // sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());

  sl.registerLazySingleton<FirebaseUserDataSource>(
      () => FirebaseUserDataSourceImpl());

  sl.registerLazySingleton<LocalUserDataSource>(
      () => LocalUserDataSourceImpl());

  sl.registerLazySingleton<FirebaseUserDetailsDataSource>(
      () => FirebaseUserDetailsDataSourceImpl());

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        firebaseUserDataSource: sl(),
        localUserDataSource: sl(),
      ));
  sl.registerLazySingleton<UserDetailsRepository>(
      () => UserDetailsRepositoryImpl(
            dataSource: sl(),
            localDataSource: sl(),
          ));

  sl.registerLazySingleton(() => GetUsersDataUsecase(sl()));
  sl.registerLazySingleton(() => CreateUsersDataUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUsersDataUsecase(sl()));
  sl.registerLazySingleton(() => DeleteUserDataUsecase(sl()));
}
