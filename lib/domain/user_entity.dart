import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/user_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/user_entity.g.dart';

@JsonSerializable()
class UserEntity {
	int? status = 0;
	String? message = '';
	List<UserData>? data = [];

	UserEntity();

	factory UserEntity.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UserData {
	String? id = '';
	String? name = '';
	String? housename = '';
	String? flatno = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? landmark = '';
	String? place = '';
	String? district = '';
	String? phone = '';
	String? country = '';

	UserData();

	factory UserData.fromJson(Map<String, dynamic> json) => $UserDataFromJson(json);

	Map<String, dynamic> toJson() => $UserDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}