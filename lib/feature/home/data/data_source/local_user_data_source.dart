import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

abstract class LocalUserDataSource {
  Future<List<UserModel>> getUserList({required NoParamsModel params});
  Future<bool> clearUsers({required NoParamsModel params});
  Future cacheUsers({required List<UserModel> users});
}
