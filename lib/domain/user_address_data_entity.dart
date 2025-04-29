import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/user_address_data_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/user_address_data_entity.g.dart';

@JsonSerializable()
class UserAddressDataEntity {
	int? status = 0;
	String? message = '';
	List<UserAddressDataData>? data = [];

	UserAddressDataEntity();

	factory UserAddressDataEntity.fromJson(Map<String, dynamic> json) => $UserAddressDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserAddressDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UserAddressDataData {
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
	String? pincode = '';
	String? country = '';
	String? state='';

	UserAddressDataData();

	factory UserAddressDataData.fromJson(Map<String, dynamic> json) => $UserAddressDataDataFromJson(json);

	Map<String, dynamic> toJson() => $UserAddressDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}