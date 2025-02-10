import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/core/network_repository/network_repository.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';
import 'package:product_listing/feature/user_details/data/data_source/user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';

class UserDetailsDataSourceImpl extends UserDetailsDataSource {
  UserDetailsDataSourceImpl();

  static final db = FirebaseFirestore.instance;

  @override
  Future<bool> createUser({required CreateUserRequestModel params}) async {
    try {
      await db.collection('users').add(params.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
