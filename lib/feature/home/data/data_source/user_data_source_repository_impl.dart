import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_listing/core/models/no_param_model.dart';
import 'package:product_listing/core/network_repository/network_repository.dart';
import 'package:product_listing/feature/home/data/data_source/user_data_source_repository.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

class UserDataSourceRepositoryImpl extends UserDataSourceRepository {
  final NetworkRepository networkRepository;

  UserDataSourceRepositoryImpl({required this.networkRepository});

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
}
