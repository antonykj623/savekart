import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/user_address_data_entity.dart';

UserAddressDataEntity $UserAddressDataEntityFromJson(
    Map<String, dynamic> json) {
  final UserAddressDataEntity userAddressDataEntity = UserAddressDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userAddressDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userAddressDataEntity.message = message;
  }
  final List<UserAddressDataData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<UserAddressDataData>(e) as UserAddressDataData)
      .toList();
  if (data != null) {
    userAddressDataEntity.data = data;
  }
  return userAddressDataEntity;
}

Map<String, dynamic> $UserAddressDataEntityToJson(
    UserAddressDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension UserAddressDataEntityExtension on UserAddressDataEntity {
  UserAddressDataEntity copyWith({
    int? status,
    String? message,
    List<UserAddressDataData>? data,
  }) {
    return UserAddressDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UserAddressDataData $UserAddressDataDataFromJson(Map<String, dynamic> json) {
  final UserAddressDataData userAddressDataData = UserAddressDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userAddressDataData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userAddressDataData.name = name;
  }
  final String? housename = jsonConvert.convert<String>(json['housename']);
  if (housename != null) {
    userAddressDataData.housename = housename;
  }
  final String? flatno = jsonConvert.convert<String>(json['flatno']);
  if (flatno != null) {
    userAddressDataData.flatno = flatno;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    userAddressDataData.userId = userId;
  }
  final String? landmark = jsonConvert.convert<String>(json['landmark']);
  if (landmark != null) {
    userAddressDataData.landmark = landmark;
  }
  final String? place = jsonConvert.convert<String>(json['place']);
  if (place != null) {
    userAddressDataData.place = place;
  }
  final String? district = jsonConvert.convert<String>(json['district']);
  if (district != null) {
    userAddressDataData.district = district;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userAddressDataData.phone = phone;
  }
  final String? pincode = jsonConvert.convert<String>(json['pincode']);
  if (pincode != null) {
    userAddressDataData.pincode = pincode;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    userAddressDataData.country = country;
  }
  return userAddressDataData;
}

Map<String, dynamic> $UserAddressDataDataToJson(UserAddressDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['housename'] = entity.housename;
  data['flatno'] = entity.flatno;
  data['user_id'] = entity.userId;
  data['landmark'] = entity.landmark;
  data['place'] = entity.place;
  data['district'] = entity.district;
  data['phone'] = entity.phone;
  data['pincode'] = entity.pincode;
  data['country'] = entity.country;
  return data;
}

extension UserAddressDataDataExtension on UserAddressDataData {
  UserAddressDataData copyWith({
    String? id,
    String? name,
    String? housename,
    String? flatno,
    String? userId,
    String? landmark,
    String? place,
    String? district,
    String? phone,
    String? pincode,
    String? country,
  }) {
    return UserAddressDataData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..housename = housename ?? this.housename
      ..flatno = flatno ?? this.flatno
      ..userId = userId ?? this.userId
      ..landmark = landmark ?? this.landmark
      ..place = place ?? this.place
      ..district = district ?? this.district
      ..phone = phone ?? this.phone
      ..pincode = pincode ?? this.pincode
      ..country = country ?? this.country;
  }
}