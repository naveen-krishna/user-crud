import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/user_details/domain/entity/update_user_request_entity.dart';

class UpdateUserRequestModel
    extends Mapper<UpdateUserRequestEntity, UpdateUserRequestModel> {
  String? id;

  String? name;
  String? role;
  String? startDate;
  String? endDate;

  UpdateUserRequestModel({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  UpdateUserRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    startDate = json['start-date'];
    endDate = json['end-date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['role'] = this.role;
    data['start-date'] = this.startDate;
    data['end-date'] = this.endDate;

    return data;
  }

  @override
  UpdateUserRequestModel call(UpdateUserRequestEntity object) {
    return UpdateUserRequestModel(
      id: object.id,
      name: object.name,
      role: object.role,
      startDate: object.startDate,
      endDate: object.endDate,
    );
  }
}
