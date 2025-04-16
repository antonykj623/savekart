import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/wallet_points_entity.dart';

WalletPointsEntity $WalletPointsEntityFromJson(Map<String, dynamic> json) {
  final WalletPointsEntity walletPointsEntity = WalletPointsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    walletPointsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    walletPointsEntity.message = message;
  }
  final WalletPointsData? data = jsonConvert.convert<WalletPointsData>(
      json['data']);
  if (data != null) {
    walletPointsEntity.data = data;
  }
  return walletPointsEntity;
}

Map<String, dynamic> $WalletPointsEntityToJson(WalletPointsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension WalletPointsEntityExtension on WalletPointsEntity {
  WalletPointsEntity copyWith({
    int? status,
    String? message,
    WalletPointsData? data,
  }) {
    return WalletPointsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WalletPointsData $WalletPointsDataFromJson(Map<String, dynamic> json) {
  final WalletPointsData walletPointsData = WalletPointsData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    walletPointsData.id = id;
  }
  final String? regId = jsonConvert.convert<String>(json['reg_id']);
  if (regId != null) {
    walletPointsData.regId = regId;
  }
  final String? credit = jsonConvert.convert<String>(json['credit']);
  if (credit != null) {
    walletPointsData.credit = credit;
  }
  final String? debit = jsonConvert.convert<String>(json['debit']);
  if (debit != null) {
    walletPointsData.debit = debit;
  }
  final String? balance = jsonConvert.convert<String>(json['balance']);
  if (balance != null) {
    walletPointsData.balance = balance;
  }
  final String? insDate = jsonConvert.convert<String>(json['ins_date']);
  if (insDate != null) {
    walletPointsData.insDate = insDate;
  }
  return walletPointsData;
}

Map<String, dynamic> $WalletPointsDataToJson(WalletPointsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['reg_id'] = entity.regId;
  data['credit'] = entity.credit;
  data['debit'] = entity.debit;
  data['balance'] = entity.balance;
  data['ins_date'] = entity.insDate;
  return data;
}

extension WalletPointsDataExtension on WalletPointsData {
  WalletPointsData copyWith({
    String? id,
    String? regId,
    String? credit,
    String? debit,
    String? balance,
    String? insDate,
  }) {
    return WalletPointsData()
      ..id = id ?? this.id
      ..regId = regId ?? this.regId
      ..credit = credit ?? this.credit
      ..debit = debit ?? this.debit
      ..balance = balance ?? this.balance
      ..insDate = insDate ?? this.insDate;
  }
}