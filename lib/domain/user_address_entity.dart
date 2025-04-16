import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/user_address_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/user_address_entity.g.dart';

@JsonSerializable()
class UserAddressEntity {
	int? status = 0;
	String? message = '';
	UserAddressData? data;

	UserAddressEntity();

	factory UserAddressEntity.fromJson(Map<String, dynamic> json) => $UserAddressEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserAddressEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UserAddressData {
	String? id = '';
	String? name = '';
	String? address = '';
	String? phone = '';
	@JSONField(name: "user_id")
	String? userId = '';

	UserAddressData();

	factory UserAddressData.fromJson(Map<String, dynamic> json) => $UserAddressDataFromJson(json);

	Map<String, dynamic> toJson() => $UserAddressDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}