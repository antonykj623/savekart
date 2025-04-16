import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/token_data_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/token_data_entity.g.dart';

@JsonSerializable()
class TokenDataEntity {
	int? status = 0;
	String? token = '';
	String? message = '';

	TokenDataEntity();

	factory TokenDataEntity.fromJson(Map<String, dynamic> json) => $TokenDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $TokenDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}