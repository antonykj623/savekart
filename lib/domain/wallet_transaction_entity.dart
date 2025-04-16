import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/wallet_transaction_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/wallet_transaction_entity.g.dart';

@JsonSerializable()
class WalletTransactionEntity {
	int? status = 0;
	String? message = '';
	List<WalletTransactionData>? data = [];

	WalletTransactionEntity();

	factory WalletTransactionEntity.fromJson(Map<String, dynamic> json) => $WalletTransactionEntityFromJson(json);

	Map<String, dynamic> toJson() => $WalletTransactionEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class WalletTransactionData {
	String? id = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? credit = '';
	String? debit = '';
	String? balance = '';
	@JSONField(name: "transaction_date")
	String? transactionDate = '';
	String? description = '';

	WalletTransactionData();

	factory WalletTransactionData.fromJson(Map<String, dynamic> json) => $WalletTransactionDataFromJson(json);

	Map<String, dynamic> toJson() => $WalletTransactionDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}