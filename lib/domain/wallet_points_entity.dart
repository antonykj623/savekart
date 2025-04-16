import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/wallet_points_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/wallet_points_entity.g.dart';

@JsonSerializable()
class WalletPointsEntity {
	int? status = 0;
	String? message = '';
	WalletPointsData? data;

	WalletPointsEntity();

	factory WalletPointsEntity.fromJson(Map<String, dynamic> json) => $WalletPointsEntityFromJson(json);

	Map<String, dynamic> toJson() => $WalletPointsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WalletPointsData {
	String? id = '';
	@JSONField(name: "reg_id")
	String? regId = '';
	String? credit = '';
	String? debit = '';
	String? balance = '';
	@JSONField(name: "ins_date")
	String? insDate = '';

	WalletPointsData();

	factory WalletPointsData.fromJson(Map<String, dynamic> json) => $WalletPointsDataFromJson(json);

	Map<String, dynamic> toJson() => $WalletPointsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}