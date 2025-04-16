import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/cart_data_exist_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/cart_data_exist_entity.g.dart';

@JsonSerializable()
class CartDataExistEntity {
	int? status = 0;
	String? message = '';
	List<CartDataExistData>? data = [];

	CartDataExistEntity();

	factory CartDataExistEntity.fromJson(Map<String, dynamic> json) => $CartDataExistEntityFromJson(json);

	Map<String, dynamic> toJson() => $CartDataExistEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CartDataExistData {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	String? quantity = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? status = '';

	CartDataExistData();

	factory CartDataExistData.fromJson(Map<String, dynamic> json) => $CartDataExistDataFromJson(json);

	Map<String, dynamic> toJson() => $CartDataExistDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}