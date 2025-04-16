import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/user_entity.dart';

UserEntity $UserEntityFromJson(Map<String, dynamic> json) {
  final UserEntity userEntity = UserEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    userEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    userEntity.message = message;
  }
  final List<UserData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<UserData>(e) as UserData).toList();
  if (data != null) {
    userEntity.data = data;
  }
  return userEntity;
}

Map<String, dynamic> $UserEntityToJson(UserEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension UserEntityExtension on UserEntity {
  UserEntity copyWith({
    int? status,
    String? message,
    List<UserData>? data,
  }) {
    return UserEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

UserData $UserDataFromJson(Map<String, dynamic> json) {
  final UserData userData = UserData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    userData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    userData.name = name;
  }
  final String? housename = jsonConvert.convert<String>(json['housename']);
  if (housename != null) {
    userData.housename = housename;
  }
  final String? flatno = jsonConvert.convert<String>(json['flatno']);
  if (flatno != null) {
    userData.flatno = flatno;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    userData.userId = userId;
  }
  final String? landmark = jsonConvert.convert<String>(json['landmark']);
  if (landmark != null) {
    userData.landmark = landmark;
  }
  final String? place = jsonConvert.convert<String>(json['place']);
  if (place != null) {
    userData.place = place;
  }
  final String? district = jsonConvert.convert<String>(json['district']);
  if (district != null) {
    userData.district = district;
  }
  final String? phone = jsonConvert.convert<String>(json['phone']);
  if (phone != null) {
    userData.phone = phone;
  }
  final String? country = jsonConvert.convert<String>(json['country']);
  if (country != null) {
    userData.country = country;
  }
  return userData;
}

Map<String, dynamic> $UserDataToJson(UserData entity) {
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
  data['country'] = entity.country;
  return data;
}

extension UserDataExtension on UserData {
  UserData copyWith({
    String? id,
    String? name,
    String? housename,
    String? flatno,
    String? userId,
    String? landmark,
    String? place,
    String? district,
    String? phone,
    String? country,
  }) {
    return UserData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..housename = housename ?? this.housename
      ..flatno = flatno ?? this.flatno
      ..userId = userId ?? this.userId
      ..landmark = landmark ?? this.landmark
      ..place = place ?? this.place
      ..district = district ?? this.district
      ..phone = phone ?? this.phone
      ..country = country ?? this.country;
  }
}