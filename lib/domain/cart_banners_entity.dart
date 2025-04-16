import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/cart_banners_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/cart_banners_entity.g.dart';

@JsonSerializable()
class CartBannersEntity {
	int? status = 0;
	String? message = '';
	List<CartBannersData>? data = [];

	CartBannersEntity();

	factory CartBannersEntity.fromJson(Map<String, dynamic> json) => $CartBannersEntityFromJson(json);

	Map<String, dynamic> toJson() => $CartBannersEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CartBannersData {
	String? id = '';
	@JSONField(name: "image_file")
	String? imageFile = '';
	@JSONField(name: "order_number")
	String? orderNumber = '';
	String? status = '';

	CartBannersData();

	factory CartBannersData.fromJson(Map<String, dynamic> json) => $CartBannersDataFromJson(json);

	Map<String, dynamic> toJson() => $CartBannersDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}