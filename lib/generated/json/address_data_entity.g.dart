import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/address_data_entity.dart';

AddressDataEntity $AddressDataEntityFromJson(Map<String, dynamic> json) {
  final AddressDataEntity addressDataEntity = AddressDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    addressDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    addressDataEntity.message = message;
  }
  final List<AddressDataData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<AddressDataData>(e) as AddressDataData)
      .toList();
  if (data != null) {
    addressDataEntity.data = data;
  }
  return addressDataEntity;
}

Map<String, dynamic> $AddressDataEntityToJson(AddressDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension AddressDataEntityExtension on AddressDataEntity {
  AddressDataEntity copyWith({
    int? status,
    String? message,
    List<AddressDataData>? data,
  }) {
    return AddressDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AddressDataData $AddressDataDataFromJson(Map<String, dynamic> json) {
  final AddressDataData addressDataData = AddressDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    addressDataData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    addressDataData.name = name;
  }
  final String? address = jsonConvert.convert<String>(json['address']);
  if (address != null) {
    addressDataData.address = address;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    addressDataData.phone = phone;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    addressDataData.userId = userId;
  }
  return addressDataData;
}

Map<String, dynamic> $AddressDataDataToJson(AddressDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['address'] = entity.address;
  data['phone'] = entity.phone;
  data['user_id'] = entity.userId;
  return data;
}

extension AddressDataDataExtension on AddressDataData {
  AddressDataData copyWith({
    String? id,
    String? name,
    String? address,
    String? phone,
    String? userId,
  }) {
    return AddressDataData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..address = address ?? this.address
      ..phone = phone ?? this.phone
      ..userId = userId ?? this.userId;
  }
}