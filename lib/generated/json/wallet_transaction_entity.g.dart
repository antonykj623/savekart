import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/wallet_transaction_entity.dart';

WalletTransactionEntity $WalletTransactionEntityFromJson(
    Map<String, dynamic> json) {
  final WalletTransactionEntity walletTransactionEntity = WalletTransactionEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    walletTransactionEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    walletTransactionEntity.message = message;
  }
  final List<WalletTransactionData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<WalletTransactionData>(e) as WalletTransactionData)
      .toList();
  if (data != null) {
    walletTransactionEntity.data = data;
  }
  return walletTransactionEntity;
}

Map<String, dynamic> $WalletTransactionEntityToJson(
    WalletTransactionEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension WalletTransactionEntityExtension on WalletTransactionEntity {
  WalletTransactionEntity copyWith({
    int? status,
    String? message,
    List<WalletTransactionData>? data,
  }) {
    return WalletTransactionEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WalletTransactionData $WalletTransactionDataFromJson(
    Map<String, dynamic> json) {
  final WalletTransactionData walletTransactionData = WalletTransactionData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    walletTransactionData.id = id;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    walletTransactionData.userId = userId;
  }
  final String? credit = jsonConvert.convert<String>(json['credit']);
  if (credit != null) {
    walletTransactionData.credit = credit;
  }
  final String? debit = jsonConvert.convert<String>(json['debit']);
  if (debit != null) {
    walletTransactionData.debit = debit;
  }
  final String? balance = jsonConvert.convert<String>(json['balance']);
  if (balance != null) {
    walletTransactionData.balance = balance;
  }
  final String? transactionDate = jsonConvert.convert<String>(
      json['transaction_date']);
  if (transactionDate != null) {
    walletTransactionData.transactionDate = transactionDate;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    walletTransactionData.description = description;
  }
  return walletTransactionData;
}

Map<String, dynamic> $WalletTransactionDataToJson(
    WalletTransactionData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['user_id'] = entity.userId;
  data['credit'] = entity.credit;
  data['debit'] = entity.debit;
  data['balance'] = entity.balance;
  data['transaction_date'] = entity.transactionDate;
  data['description'] = entity.description;
  return data;
}

extension WalletTransactionDataExtension on WalletTransactionData {
  WalletTransactionData copyWith({
    String? id,
    String? userId,
    String? credit,
    String? debit,
    String? balance,
    String? transactionDate,
    String? description,
  }) {
    return WalletTransactionData()
      ..id = id ?? this.id
      ..userId = userId ?? this.userId
      ..credit = credit ?? this.credit
      ..debit = debit ?? this.debit
      ..balance = balance ?? this.balance
      ..transactionDate = transactionDate ?? this.transactionDate
      ..description = description ?? this.description;
  }
}