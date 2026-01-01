import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/soldcount_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/soldcount_entity.g.dart';

@JsonSerializable()
class SoldcountEntity {
	int? status = 0;
	String? message = '';
	@JSONField(name: "available_count")
	int? availableCount = 0;

	SoldcountEntity();

	factory SoldcountEntity.fromJson(Map<String, dynamic> json) => $SoldcountEntityFromJson(json);

	Map<String, dynamic> toJson() => $SoldcountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}