import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/network_data_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/network_data_entity.g.dart';

@JsonSerializable()
class NetworkDataEntity {
	int? status = 0;
	String? message = '';
	NetworkDataData? data;

	NetworkDataEntity();

	factory NetworkDataEntity.fromJson(Map<String, dynamic> json) => $NetworkDataEntityFromJson(json);

	Map<String, dynamic> toJson() => $NetworkDataEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class NetworkDataData {
	String? id = '';
	String? position = '';
	@JSONField(name: "position_downline_setup_default")
	String? positionDownlineSetupDefault = '';
	@JSONField(name: "position_next")
	String? positionNext = '';
	@JSONField(name: "binary_left")
	String? binaryLeft = '';
	@JSONField(name: "binary_right")
	String? binaryRight = '';
	@JSONField(name: "binary_matched")
	String? binaryMatched = '';
	@JSONField(name: "carry_left")
	String? carryLeft = '';
	@JSONField(name: "member_status")
	String? memberStatus = '';
	@JSONField(name: "carry_right")
	String? carryRight = '';
	@JSONField(name: "binary_amt")
	String? binaryAmt = '';
	@JSONField(name: "referral_commission_amt")
	String? referralCommissionAmt = '';
	@JSONField(name: "level_amt")
	String? levelAmt = '';
	@JSONField(name: "achievement_amt")
	String? achievementAmt = '';

	NetworkDataData();

	factory NetworkDataData.fromJson(Map<String, dynamic> json) => $NetworkDataDataFromJson(json);

	Map<String, dynamic> toJson() => $NetworkDataDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}