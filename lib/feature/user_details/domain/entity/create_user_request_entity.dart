class CreateUserRequestEntity {
  String? id;

  String? name;
  String? role;
  String? startDate;
  String? endDate;

  CreateUserRequestEntity({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  CreateUserRequestEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    startDate = json['start-date'];
    endDate = json['end-date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['role'] = this.role;
    data['start-date'] = this.startDate;
    data['end-date'] = this.endDate;

    return data;
  }
}
