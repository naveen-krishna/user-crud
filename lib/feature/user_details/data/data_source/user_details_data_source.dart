import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';

abstract class UserDetailsDataSource {
  Future<bool> createUser({required CreateUserRequestModel params});
}
