import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/searched_products_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/searched_products_entity.g.dart';

@JsonSerializable()
class SearchedProductsEntity {
	int? status = 0;
	String? message = '';
	List<SearchedProductsData>? data = [];

	SearchedProductsEntity();

	factory SearchedProductsEntity.fromJson(Map<String, dynamic> json) => $SearchedProductsEntityFromJson(json);

	Map<String, dynamic> toJson() => $SearchedProductsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SearchedProductsData {
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

	SearchedProductsData();

	factory SearchedProductsData.fromJson(Map<String, dynamic> json) => $SearchedProductsDataFromJson(json);

	Map<String, dynamic> toJson() => $SearchedProductsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}