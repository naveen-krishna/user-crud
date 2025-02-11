import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

class LocalUserDataSourceImpl extends LocalUserDataSource {
  static final db = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getUserList({required NoParamsModel params}) async {
    try {
      // todo: implement local getUserList
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
  Future<bool> clearUsers({required NoParamsModel params}) async {
    // todo: implement local clear data

    try {
      await db.collection('users');
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future cacheUsers({required List<UserModel> users}) async {
    // todo: write to local database

    try {
      await db.collection('users');
    } catch (e) {}
  }
}
