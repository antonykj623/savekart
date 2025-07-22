import 'package:savekart/domain/product_details_entity.dart';
import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/product_sub_category_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/product_sub_category_entity.g.dart';

@JsonSerializable()
class ProductSubCategoryEntity {
	int? status = 0;
	String? message = '';
	List<ProductSubCategoryData>? data = [];

	ProductSubCategoryEntity();

	factory ProductSubCategoryEntity.fromJson(Map<String, dynamic> json) => $ProductSubCategoryEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductSubCategoryEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductSubCategoryData {
	ProductSubCategoryDataCategory? category;
	List<ProductSubCategoryDataData>? data = [];

	ProductSubCategoryData();

	factory ProductSubCategoryData.fromJson(Map<String, dynamic> json) => $ProductSubCategoryDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductSubCategoryDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductSubCategoryDataCategory {
	@JSONField(name: "sub_category_id")
	String? subCategoryId = '';
	@JSONField(name: "sub_category_name")
	String? subCategoryName = '';

	ProductSubCategoryDataCategory();

	factory ProductSubCategoryDataCategory.fromJson(Map<String, dynamic> json) => $ProductSubCategoryDataCategoryFromJson(json);

	Map<String, dynamic> toJson() => $ProductSubCategoryDataCategoryToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductSubCategoryDataData {
	String? id = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "product_code")
	String? productCode = '';
	String? hsncode = '';
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
	dynamic sideImage3;
	@JSONField(name: "side_image4")
	dynamic sideImage4;
	@JSONField(name: "unit_id")
	String? unitId = '';
	@JSONField(name: "size_enabled")
	String? sizeEnabled = '';
	@JSONField(name: "color_enabled")
	String? colorEnabled = '';
	String? color = '';
	String? size = '';
	@JSONField(name: "vendor_id")
	String? vendorId = '';
	@JSONField(name: "return_policy_id")
	String? returnPolicyId = '';
	@JSONField(name: "offered_item_status")
	String? offeredItemStatus = '';
	String? status = '';
	String? returnable = '';
	@JSONField(name: "return_days")
	String? returnDays = '';
	String? upd = '';

	ProductSubCategoryDataData();

	factory ProductSubCategoryDataData.fromJson(Map<String, dynamic> json) => $ProductSubCategoryDataDataFromJson(json);

  ProductDetailsData get data => data;



	Map<String, dynamic> toJson() => $ProductSubCategoryDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}