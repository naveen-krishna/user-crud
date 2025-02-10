import 'package:product_listing/core/model_to_entity_mapper/mapper.dart';
import 'package:product_listing/feature/home/data/models/user_model.dart';

class UserEntity extends Mapper<UserModel, UserEntity> {
  String? id;
  String? name;
  String? role;
  String? startDate;
  String? endDate;

  UserEntity({
    this.id,
    this.name,
    this.role,
    this.startDate,
    this.endDate,
  });

  @override
  UserEntity call(UserModel object) {
    return UserEntity(
      id: object.id,
      name: object.name,
      role: object.role,
      startDate: object.startDate,
      endDate: object.endDate,
    );
  }
}
