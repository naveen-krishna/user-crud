import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String role;
  @HiveField(3)
  String startDate;
  @HiveField(4)
  String endDate;

  UserModel({
    required this.id,
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate,
  });

  factory UserModel.fromJson(String id, Map<String, dynamic> json) => UserModel(
        id: id,
        name: json["name"],
        role: json["role"],
        startDate: json["start-date"] ?? '',
        endDate: json["end-date"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "start-date": startDate,
        "end-date": endDate,
      };
}
