import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/order_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
	int? status = 0;
	String? message = '';
	List<OrderData>? data = [];

	OrderEntity();

	factory OrderEntity.fromJson(Map<String, dynamic> json) => $OrderEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderData {
	String? id = '';
	@JSONField(name: "reg_id")
	String? regId = '';
	@JSONField(name: "date_order")
	String? dateOrder = '';
	@JSONField(name: "delivery_date")
	dynamic deliveryDate;
	@JSONField(name: "address_id")
	String? addressId = '';
	String? totalprice = '';
	@JSONField(name: "payment_type")
	dynamic paymentType;
	@JSONField(name: "order_status")
	String? orderStatus = '';
	@JSONField(name: "billing_status")
	String? billingStatus = '';

	OrderData();

	factory OrderData.fromJson(Map<String, dynamic> json) => $OrderDataFromJson(json);

	Map<String, dynamic> toJson() => $OrderDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}