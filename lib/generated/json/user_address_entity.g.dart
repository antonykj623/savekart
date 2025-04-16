import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/user_address_entity.dart';

UserAddressEntity $UserAddressEntityFromJson(Map<String, dynamic> json) {
  final UserAddressEntity userAddressEntity = UserAddressEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userAddressEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userAddressEntity.message = message;
  }
  final UserAddressData? data = jsonConvert.convert<UserAddressData>(
      json['data']);
  if (data != null) {
    userAddressEntity.data = data;
  }
  return userAddressEntity;
}

Map<String, dynamic> $UserAddressEntityToJson(UserAddressEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension UserAddressEntityExtension on UserAddressEntity {
  UserAddressEntity copyWith({
    int? status,
    String? message,
    UserAddressData? data,
  }) {
    return UserAddressEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UserAddressData $UserAddressDataFromJson(Map<String, dynamic> json) {
  final UserAddressData userAddressData = UserAddressData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userAddressData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userAddressData.name = name;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    userAddressData.address = address;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userAddressData.phone = phone;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    userAddressData.userId = userId;
  }
  return userAddressData;
}

Map<String, dynamic> $UserAddressDataToJson(UserAddressData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['address'] = entity.address;
  data['phone'] = entity.phone;
  data['user_id'] = entity.userId;
  return data;
}

extension UserAddressDataExtension on UserAddressData {
  UserAddressData copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? userId,
  }) {
    return UserAddressData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..address = address ?? this.address
      ..phone = phone ?? this.phone
      ..userId = userId ?? this.userId;
  }
}