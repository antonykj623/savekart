import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/product_details_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/product_details_entity.g.dart';

@JsonSerializable()
class ProductDetailsEntity {
	int? status = 0;
	String? message = '';
	List<ProductDetailsData>? data = [];

	ProductDetailsEntity();

	factory ProductDetailsEntity.fromJson(Map<String, dynamic> json) => $ProductDetailsEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductDetailsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductDetailsData {
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
	dynamic sideImage1;
	@JSONField(name: "side_image2")
	dynamic sideImage2;
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

	ProductDetailsData();

	factory ProductDetailsData.fromJson(Map<String, dynamic> json) => $ProductDetailsDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductDetailsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}