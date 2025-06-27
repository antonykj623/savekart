import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/pg_response_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/pg_response_entity.g.dart';

@JsonSerializable()
class PgResponseEntity {
	String? msg = '';
	@JSONField(name: "merchant_code")
	String? merchantCode = '';

	PgResponseEntity();

	factory PgResponseEntity.fromJson(Map<String, dynamic> json) => $PgResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $PgResponseEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}