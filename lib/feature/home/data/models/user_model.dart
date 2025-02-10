class UserModel {
  String id;
  String name;
  String role;
  String startDate;
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
