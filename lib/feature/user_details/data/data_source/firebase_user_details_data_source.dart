import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';
import 'package:product_listing/feature/user_details/data/models/update_user_request_model.dart';

abstract class FirebaseUserDetailsDataSource {
  Future<bool> createUser({required CreateUserRequestModel params});
  Future<bool> updateUser({required UpdateUserRequestModel params});
}
