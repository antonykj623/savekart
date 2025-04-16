import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/address_data_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/address_data_entity.g.dart';

@JsonSerializable()
class AddressDataEntity {
	int? status = 0;
	String? message = '';
	List<AddressDataData>? data = [];

	AddressDataEntity();

	factory AddressDataEntity.fromJson(Map<String, dynamic> json) => $AddressDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $AddressDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class AddressDataData {
	String? id = '';
	String? name = '';
	String? address = '';
	String? phone = '';
	@JSONField(name: "user_id")
	String? userId = '';

	AddressDataData();

	factory AddressDataData.fromJson(Map<String, dynamic> json) => $AddressDataDataFromJson(json);

	Map<String, dynamic> toJson() => $AddressDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}