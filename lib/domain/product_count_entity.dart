import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/product_count_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/product_count_entity.g.dart';

@JsonSerializable()
class ProductCountEntity {
	int? status = 0;
	String? message = '';
	List<ProductCountData>? data = [];

	ProductCountEntity();

	factory ProductCountEntity.fromJson(Map<String, dynamic> json) => $ProductCountEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductCountEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductCountData {
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

	ProductCountData();

	factory ProductCountData.fromJson(Map<String, dynamic> json) => $ProductCountDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductCountDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}