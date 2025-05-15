import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/product_by_category_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/product_by_category_entity.g.dart';

@JsonSerializable()
class ProductByCategoryEntity {
	int? status = 0;
	String? message = '';
	List<ProductByCategoryData>? data = [];

	ProductByCategoryEntity();

	factory ProductByCategoryEntity.fromJson(Map<String, dynamic> json) => $ProductByCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductByCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductByCategoryData {
	ProductByCategoryDataCategory? category;
	List<ProductByCategoryDataData>? data = [];

	ProductByCategoryData();

	factory ProductByCategoryData.fromJson(Map<String, dynamic> json) => $ProductByCategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductByCategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductByCategoryDataCategory {
	String? id = '';
	@JSONField(name: "category_name")
	String? categoryName = '';
	String? status = '';
	String? image = '';

	ProductByCategoryDataCategory();

	factory ProductByCategoryDataCategory.fromJson(Map<String, dynamic> json) => $ProductByCategoryDataCategoryFromJson(json);

	Map<String, dynamic> toJson() => $ProductByCategoryDataCategoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductByCategoryDataData {
	String? id = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "category_id")
	String? categoryId = '';
	@JSONField(name: "sub_category_id")
	String? subCategoryId = '';
	@JSONField(name: "product_description")
	String? productDescription = '';
	@JSONField(name: "product_spec")
	String? productSpec = '';
	@JSONField(name: "prime_image")
	String? primeImage = '';
	@JSONField(name: "side_image1")
	String? sideImage1 = '';
	@JSONField(name: "side_image2")
	String? sideImage2 = '';
	@JSONField(name: "side_image3")
	String? sideImage3 = '';
	@JSONField(name: "side_image4")
	String? sideImage4 = '';
	@JSONField(name: "unit_id")
	dynamic unitId;
	@JSONField(name: "size_enabled")
	String? sizeEnabled = '';
	@JSONField(name: "color_enabled")
	String? colorEnabled = '';
	String? color = '';
	String? size = '';
	@JSONField(name: "vendor_id")
	String? vendorId = '';
	String? status = '';
	@JSONField(name: "return_days")
	String? returnDays = '';

	ProductByCategoryDataData();

	factory ProductByCategoryDataData.fromJson(Map<String, dynamic> json) => $ProductByCategoryDataDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductByCategoryDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}