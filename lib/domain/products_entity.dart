import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/products_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/products_entity.g.dart';

@JsonSerializable()
class ProductsEntity {
	int? status = 0;
	String? message = '';
	List<ProductsData>? data = [];

	ProductsEntity();

	factory ProductsEntity.fromJson(Map<String, dynamic> json) => $ProductsEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductsData {
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
	String? status = '0';
	String? returnable = '';

	ProductsData();

	factory ProductsData.fromJson(Map<String, dynamic> json) => $ProductsDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}