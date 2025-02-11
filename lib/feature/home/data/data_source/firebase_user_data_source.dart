import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/models/delete_user_request_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

abstract class FirebaseUserDataSource {
  Future<List<UserModel>> getUserList({required NoParamsModel params});
  Future<bool> deleteUser({required DeleteUserRequestModel params});
}
