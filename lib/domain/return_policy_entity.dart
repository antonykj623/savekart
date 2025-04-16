import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/return_policy_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/return_policy_entity.g.dart';

@JsonSerializable()
class ReturnPolicyEntity {
	int? status = 0;
	String? message = '';
	ReturnPolicyData? data;

	ReturnPolicyEntity();

	factory ReturnPolicyEntity.fromJson(Map<String, dynamic> json) => $ReturnPolicyEntityFromJson(json);

	Map<String, dynamic> toJson() => $ReturnPolicyEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ReturnPolicyData {
	String? id = '';
	String? policy = '';
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "return_masterid")
	String? returnMasterid = '';
	@JSONField(name: "policy_id")
	String? policyId = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "updated_at")
	String? updatedAt = '';
	@JSONField(name: "return_policy_product_data_id")
	String? returnPolicyProductDataId = '';

	ReturnPolicyData();

	factory ReturnPolicyData.fromJson(Map<String, dynamic> json) => $ReturnPolicyDataFromJson(json);

	Map<String, dynamic> toJson() => $ReturnPolicyDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}