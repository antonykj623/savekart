import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/sub_category_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/sub_category_entity.g.dart';

@JsonSerializable()
class SubCategoryEntity {
	int? status = 0;
	String? message = '';
	List<SubCategoryData>? data = [];

	SubCategoryEntity();

	factory SubCategoryEntity.fromJson(Map<String, dynamic> json) => $SubCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $SubCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SubCategoryData {
	String? id = '';
	@JSONField(name: "sub_category_name")
	String? subCategoryName = '';
	@JSONField(name: "category_id")
	String? categoryId = '';
	String? status = '';
	String? image = '';

	SubCategoryData();

	factory SubCategoryData.fromJson(Map<String, dynamic> json) => $SubCategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $SubCategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}