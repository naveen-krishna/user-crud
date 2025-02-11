import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/feature/home/data/data_source/local_user_data_source.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

class LocalUserDataSourceImpl extends LocalUserDataSource {
  @override
  Future<List<UserModel>> getUserList({required NoParamsModel params}) async {
    try {
      await Hive.openBox<UserModel>('users');
      Box<UserModel> userBox = Hive.box<UserModel>('users');

      List<UserModel> userList = userBox.values.toList();

      return userList;
    } catch (e) {
      print("${e}");
      return [];
    }
  }

  @override
  Future<bool> clearUsers({required NoParamsModel params}) async {
    await Hive.openBox<UserModel>('users');
    Box<UserModel> userBox = Hive.box<UserModel>('users');

    try {
      await userBox.clear();
      return true;
    } catch (e) {
      print("${e}");

      return false;
    }
  }

  @override
  Future cacheUsers({required List<UserModel> users}) async {
    // todo: write to local database
    await Hive.openBox<UserModel>('users');
    Box<UserModel> userBox = Hive.box<UserModel>('users');

    try {
      for (var user in users) {
        await userBox.add(user);
      }
    } catch (e) {
      print("${e}");
    }
  }
}
