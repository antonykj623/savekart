import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/return_request_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/return_request_entity.g.dart';

@JsonSerializable()
class ReturnRequestEntity {
	int? status = 0;
	String? message = '';
	List<ReturnRequestData>? data = [];

	ReturnRequestEntity();

	factory ReturnRequestEntity.fromJson(Map<String, dynamic> json) => $ReturnRequestEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReturnRequestEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ReturnRequestData {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "product_return_policy_id")
	String? productReturnPolicyId = '';
	@JSONField(name: "order_id")
	String? orderId = '';
	String? image1 = '';
	String? image2 = '';
	String? image3 = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? reason = '';
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "refunded_date")
	dynamic refundedDate;
	String? status = '';
	@JSONField(name: "refund_status")
	String? refundStatus = '';

	ReturnRequestData();

	factory ReturnRequestData.fromJson(Map<String, dynamic> json) => $ReturnRequestDataFromJson(json);

	Map<String, dynamic> toJson() => $ReturnRequestDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}