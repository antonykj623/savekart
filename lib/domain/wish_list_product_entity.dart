import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/wish_list_product_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/wish_list_product_entity.g.dart';

@JsonSerializable()
class WishListProductEntity {
	int? status = 0;
	String? message = '';
	List<WishListProductData>? data = [];

	WishListProductEntity();

	factory WishListProductEntity.fromJson(Map<String, dynamic> json) => $WishListProductEntityFromJson(json);

	Map<String, dynamic> toJson() => $WishListProductEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WishListProductData {
	String? wishlistid = '';
	String? price = '';
	String? stockid = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "prime_image")
	String? primeImage = '';

	WishListProductData();

	factory WishListProductData.fromJson(Map<String, dynamic> json) => $WishListProductDataFromJson(json);

	Map<String, dynamic> toJson() => $WishListProductDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}