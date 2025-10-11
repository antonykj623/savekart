import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/network_data_entity.dart';

NetworkDataEntity $NetworkDataEntityFromJson(Map<String, dynamic> json) {
  final NetworkDataEntity networkDataEntity = NetworkDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    networkDataEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    networkDataEntity.message = message;
  }
  final NetworkDataData? data = jsonConvert.convert<NetworkDataData>(
      json['data']);
  if (data != null) {
    networkDataEntity.data = data;
  }
  return networkDataEntity;
}

Map<String, dynamic> $NetworkDataEntityToJson(NetworkDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension NetworkDataEntityExtension on NetworkDataEntity {
  NetworkDataEntity copyWith({
    int? status,
    String? message,
    NetworkDataData? data,
  }) {
    return NetworkDataEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

NetworkDataData $NetworkDataDataFromJson(Map<String, dynamic> json) {
  final NetworkDataData networkDataData = NetworkDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    networkDataData.id = id;
  }
  final String? position = jsonConvert.convert<String>(json['position']);
  if (position != null) {
    networkDataData.position = position;
  }
  final String? positionDownlineSetupDefault = jsonConvert.convert<String>(
      json['position_downline_setup_default']);
  if (positionDownlineSetupDefault != null) {
    networkDataData.positionDownlineSetupDefault = positionDownlineSetupDefault;
  }
  final String? positionNext = jsonConvert.convert<String>(
      json['position_next']);
  if (positionNext != null) {
    networkDataData.positionNext = positionNext;
  }
  final String? binaryLeft = jsonConvert.convert<String>(json['binary_left']);
  if (binaryLeft != null) {
    networkDataData.binaryLeft = binaryLeft;
  }
  final String? binaryRight = jsonConvert.convert<String>(json['binary_right']);
  if (binaryRight != null) {
    networkDataData.binaryRight = binaryRight;
  }
  final String? binaryMatched = jsonConvert.convert<String>(
      json['binary_matched']);
  if (binaryMatched != null) {
    networkDataData.binaryMatched = binaryMatched;
  }
  final String? carryLeft = jsonConvert.convert<String>(json['carry_left']);
  if (carryLeft != null) {
    networkDataData.carryLeft = carryLeft;
  }
  final String? memberStatus = jsonConvert.convert<String>(
      json['member_status']);
  if (memberStatus != null) {
    networkDataData.memberStatus = memberStatus;
  }
  final String? carryRight = jsonConvert.convert<String>(json['carry_right']);
  if (carryRight != null) {
    networkDataData.carryRight = carryRight;
  }
  final String? binaryAmt = jsonConvert.convert<String>(json['binary_amt']);
  if (binaryAmt != null) {
    networkDataData.binaryAmt = binaryAmt;
  }
  final String? referralCommissionAmt = jsonConvert.convert<String>(
      json['referral_commission_amt']);
  if (referralCommissionAmt != null) {
    networkDataData.referralCommissionAmt = referralCommissionAmt;
  }
  final String? levelAmt = jsonConvert.convert<String>(json['level_amt']);
  if (levelAmt != null) {
    networkDataData.levelAmt = levelAmt;
  }
  final String? achievementAmt = jsonConvert.convert<String>(
      json['achievement_amt']);
  if (achievementAmt != null) {
    networkDataData.achievementAmt = achievementAmt;
  }
  return networkDataData;
}

Map<String, dynamic> $NetworkDataDataToJson(NetworkDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['position'] = entity.position;
  data['position_downline_setup_default'] = entity.positionDownlineSetupDefault;
  data['position_next'] = entity.positionNext;
  data['binary_left'] = entity.binaryLeft;
  data['binary_right'] = entity.binaryRight;
  data['binary_matched'] = entity.binaryMatched;
  data['carry_left'] = entity.carryLeft;
  data['member_status'] = entity.memberStatus;
  data['carry_right'] = entity.carryRight;
  data['binary_amt'] = entity.binaryAmt;
  data['referral_commission_amt'] = entity.referralCommissionAmt;
  data['level_amt'] = entity.levelAmt;
  data['achievement_amt'] = entity.achievementAmt;
  return data;
}

extension NetworkDataDataExtension on NetworkDataData {
  NetworkDataData copyWith({
    String? id,
    String? position,
    String? positionDownlineSetupDefault,
    String? positionNext,
    String? binaryLeft,
    String? binaryRight,
    String? binaryMatched,
    String? carryLeft,
    String? memberStatus,
    String? carryRight,
    String? binaryAmt,
    String? referralCommissionAmt,
    String? levelAmt,
    String? achievementAmt,
  }) {
    return NetworkDataData()
      ..id = id ?? this.id
      ..position = position ?? this.position
      ..positionDownlineSetupDefault = positionDownlineSetupDefault ??
          this.positionDownlineSetupDefault
      ..positionNext = positionNext ?? this.positionNext
      ..binaryLeft = binaryLeft ?? this.binaryLeft
      ..binaryRight = binaryRight ?? this.binaryRight
      ..binaryMatched = binaryMatched ?? this.binaryMatched
      ..carryLeft = carryLeft ?? this.carryLeft
      ..memberStatus = memberStatus ?? this.memberStatus
      ..carryRight = carryRight ?? this.carryRight
      ..binaryAmt = binaryAmt ?? this.binaryAmt
      ..referralCommissionAmt = referralCommissionAmt ??
          this.referralCommissionAmt
      ..levelAmt = levelAmt ?? this.levelAmt
      ..achievementAmt = achievementAmt ?? this.achievementAmt;
  }
}