import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';

class CreateUserRequestModel
    extends Mapper<CreateUserRequestEntity, CreateUserRequestModel> {
  String? name;
  String? role;
  String? startDate;

  CreateUserRequestModel({this.name, this.role, this.startDate});

  CreateUserRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    role = json['role'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['start-date'] = this.startDate;
    return data;
  }

  @override
  CreateUserRequestModel call(CreateUserRequestEntity object) {
    return CreateUserRequestModel(
        name: object.name, role: object.role, startDate: object.startDate);
  }
}
