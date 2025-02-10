import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/user_details/data/models/create_user_request_model.dart';

class CreateUserRequestEntity {
  String? name;
  String? role;
  String? startDate;

  CreateUserRequestEntity({this.name, this.role, this.startDate});

  CreateUserRequestEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    startDate = json['start-date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['start-date'] = this.startDate;
    return data;
  }
}
