class DeleteUserRequestEntity {
  String? id;

  String? name;
  String? role;
  String? startDate;
  String? endDate;

  DeleteUserRequestEntity({
    this.id,
  });

  DeleteUserRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;

    return data;
  }
}
