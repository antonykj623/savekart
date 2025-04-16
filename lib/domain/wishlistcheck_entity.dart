import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/wishlistcheck_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/wishlistcheck_entity.g.dart';

@JsonSerializable()
class WishlistcheckEntity {
	int? status = 0;
	String? message = '';
	List<WishlistcheckData>? data = [];

	WishlistcheckEntity();

	factory WishlistcheckEntity.fromJson(Map<String, dynamic> json) => $WishlistcheckEntityFromJson(json);

	Map<String, dynamic> toJson() => $WishlistcheckEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WishlistcheckData {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "product_stock_id")
	String? productStockId = '';
	@JSONField(name: "user_id")
	String? userId = '';

	WishlistcheckData();

	factory WishlistcheckData.fromJson(Map<String, dynamic> json) => $WishlistcheckDataFromJson(json);

	Map<String, dynamic> toJson() => $WishlistcheckDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}