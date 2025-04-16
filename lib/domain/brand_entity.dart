import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/brand_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/brand_entity.g.dart';

@JsonSerializable()
class BrandEntity {
	int? status = 0;
	String? message = '';
	List<BrandData>? data = [];

	BrandEntity();

	factory BrandEntity.fromJson(Map<String, dynamic> json) => $BrandEntityFromJson(json);

	Map<String, dynamic> toJson() => $BrandEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class BrandData {
	String? id = '';
	String? name = '';
	String? image = '';
	String? status = '';

	BrandData();

	factory BrandData.fromJson(Map<String, dynamic> json) => $BrandDataFromJson(json);

	Map<String, dynamic> toJson() => $BrandDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}