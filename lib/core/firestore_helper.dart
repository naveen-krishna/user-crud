// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:product_listing/feature/home/domain/entities/user_entity.dart';

// class FirestoreHelper {
//   static final db = FirebaseFirestore.instance;

//   static Future<QuerySnapshot> get() async {
//     final QuerySnapshot result = await db.collection("users").get();

//     return result;
//   }

//   static Future<String> create(
//       {required String collection, required Map<String, dynamic> data}) async {
//     final result = await db.collection(collection).add(data);
//     return result.id;
//   }

//   static Future<String> update(
//       {required String collection, required Map<String, dynamic> data}) async {
//     final result = await db.collection(collection).;
//     return result.id;
//   }

//   static Future<String> delete(
//       {required String collection, required Map<String, dynamic> data}) async {
//     final result = await db.collection(collection).doc();
//     return result.id;
//   }
// }
