import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/app_version_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/app_version_entity.g.dart';

@JsonSerializable()
class AppVersionEntity {
	int? status = 0;
	String? message = '';
	AppVersionData? data;

	AppVersionEntity();

	factory AppVersionEntity.fromJson(Map<String, dynamic> json) => $AppVersionEntityFromJson(json);

	Map<String, dynamic> toJson() => $AppVersionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AppVersionData {
	String? id = '';
	String? version = '';

	AppVersionData();

	factory AppVersionData.fromJson(Map<String, dynamic> json) => $AppVersionDataFromJson(json);

	Map<String, dynamic> toJson() => $AppVersionDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}