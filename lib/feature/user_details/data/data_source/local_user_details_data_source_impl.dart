import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_listing/feature/user_details/data/data_source/firebase_user_details_data_source.dart';
import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';
import 'package:product_listing/feature/home/data/models/delete_user_request_model.dart';
import 'package:product_listing/feature/user_details/data/models/update_user_request_model.dart';

class LocalUserDetailsDataSourceImpl extends FirebaseUserDetailsDataSource {
  LocalUserDetailsDataSourceImpl();

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

  @override
  Future<bool> updateUser({required UpdateUserRequestModel params}) async {
    try {
      await db.collection('users').doc(params.id).update(params.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
