import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/firebase_user_data_source.dart';
import 'package:product_listing/feature/home/data/models/delete_user_request_model.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

class FirebaseUserDataSourceImpl extends FirebaseUserDataSource {
  static final db = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getUserList({required NoParamsModel params}) async {
    try {
      final QuerySnapshot response = await db.collection("users").get();

      List<UserModel> userList = [];

      for (var doc in response.docs) {
        userList.add(
            UserModel.fromJson(doc.id, doc.data() as Map<String, dynamic>));
      }
      return userList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<bool> deleteUser({required DeleteUserRequestModel params}) async {
    try {
      await db.collection('users').doc(params.id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
