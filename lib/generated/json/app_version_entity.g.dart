import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/app_version_entity.dart';

AppVersionEntity $AppVersionEntityFromJson(Map<String, dynamic> json) {
  final AppVersionEntity appVersionEntity = AppVersionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    appVersionEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    appVersionEntity.message = message;
  }
  final AppVersionData? data = jsonConvert.convert<AppVersionData>(
      json['data']);
  if (data != null) {
    appVersionEntity.data = data;
  }
  return appVersionEntity;
}

Map<String, dynamic> $AppVersionEntityToJson(AppVersionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension AppVersionEntityExtension on AppVersionEntity {
  AppVersionEntity copyWith({
    int? status,
    String? message,
    AppVersionData? data,
  }) {
    return AppVersionEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

AppVersionData $AppVersionDataFromJson(Map<String, dynamic> json) {
  final AppVersionData appVersionData = AppVersionData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    appVersionData.id = id;
  }
  final String? version = jsonConvert.convert<String>(json['version']);
  if (version != null) {
    appVersionData.version = version;
  }
  return appVersionData;
}

Map<String, dynamic> $AppVersionDataToJson(AppVersionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['version'] = entity.version;
  return data;
}

extension AppVersionDataExtension on AppVersionData {
  AppVersionData copyWith({
    String? id,
    String? version,
  }) {
    return AppVersionData()
      ..id = id ?? this.id
      ..version = version ?? this.version;
  }
}