import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/subcategory_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/subcategory_entity.g.dart';

@JsonSerializable()
class SubcategoryEntity {
	int? status = 0;
	String? message = '';
	List<SubcategoryData>? data = [];

	SubcategoryEntity();

	factory SubcategoryEntity.fromJson(Map<String, dynamic> json) => $SubcategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $SubcategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SubcategoryData {
	@JSONField(name: "sub_category_id")
	String? subCategoryId = '';
	@JSONField(name: "sub_category_name")
	String? subCategoryName = '';

	SubcategoryData();

	factory SubcategoryData.fromJson(Map<String, dynamic> json) => $SubcategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $SubcategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}