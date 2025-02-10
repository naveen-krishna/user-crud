import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:product_listing/core/constants/string_constants.dart';
import 'package:product_listing/core/models/api_failure_model.dart';

Future<Either<ApiFailureModel, T>> baseMethodExceptions<T>(
  Future<Either<ApiFailureModel, T>> Function() baseMethod,
) async {
  try {
    bool isInternetConnected = await checkInternetConnection();

    if (!isInternetConnected) {
      return Left(ApiFailureModel(message: internetNotConnected));
    }
    return await baseMethod();
  } catch (e) {
    return Left(ApiFailureModel(message: somethingWentWrong));
  }
}

checkInternetConnection() async {
  final List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();
  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  } else {
    return true;
  }
}
