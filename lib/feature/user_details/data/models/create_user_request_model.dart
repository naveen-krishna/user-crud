import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/user_details/domain/entity/create_user_request_entity.dart';

class CreateUserRequestModel
    extends Mapper<CreateUserRequestEntity, CreateUserRequestModel> {
  String? id;

  String? name;
  String? role;
  String? startDate;
  String? endDate;

  CreateUserRequestModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  CreateUserRequestModel.fromJson(Map<String, dynamic> json) {
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

  @override
  CreateUserRequestModel call(CreateUserRequestEntity object) {
    return CreateUserRequestModel(
      id: object.id,
      name: object.name,
      role: object.role,
      startDate: object.startDate,
      endDate: object.endDate,
    );
  }
}
