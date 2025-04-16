import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/category_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
	int? status = 0;
	String? message = '';
	List<CategoryData>? data = [];

	CategoryEntity();

	factory CategoryEntity.fromJson(Map<String, dynamic> json) => $CategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $CategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CategoryData {
	String? id = '';
	@JSONField(name: "category_name")
	String? categoryName = '';
	String? status = '';
	String? image = '';

	CategoryData();

	factory CategoryData.fromJson(Map<String, dynamic> json) => $CategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $CategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}