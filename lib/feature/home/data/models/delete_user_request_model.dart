import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/home/domain/entities/delete_user_request_entity.dart';

class DeleteUserRequestModel
    extends Mapper<DeleteUserRequestEntity, DeleteUserRequestModel> {
  String? id;

  DeleteUserRequestModel({
    this.id,
  });

  DeleteUserRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    return data;
  }

  @override
  DeleteUserRequestModel call(DeleteUserRequestEntity object) {
    return DeleteUserRequestModel(
      id: object.id,
    );
  }
}
