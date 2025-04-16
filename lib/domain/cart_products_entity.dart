import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/cart_products_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/cart_products_entity.g.dart';

@JsonSerializable()
class CartProductsEntity {
	int? status = 0;
	String? message = '';
	List<CartProductsData>? data = [];

	CartProductsEntity();

	factory CartProductsEntity.fromJson(Map<String, dynamic> json) => $CartProductsEntityFromJson(json);

	Map<String, dynamic> toJson() => $CartProductsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CartProductsData {
	String? cartid = '';
	String? ppredemption = '';
	String? quantity = '';
	@JSONField(name: "points_redeemed")
	String? pointsRedeemed = '';
	String? price = '';
	String? savekartprice = '';
	String? stockid = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "prime_image")
	String? primeImage = '';
	String? size = '';

	CartProductsData();

	factory CartProductsData.fromJson(Map<String, dynamic> json) => $CartProductsDataFromJson(json);

	Map<String, dynamic> toJson() => $CartProductsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}