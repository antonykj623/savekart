import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/return_policy_entity.dart';

ReturnPolicyEntity $ReturnPolicyEntityFromJson(Map<String, dynamic> json) {
  final ReturnPolicyEntity returnPolicyEntity = ReturnPolicyEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    returnPolicyEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    returnPolicyEntity.message = message;
  }
  final ReturnPolicyData? data = jsonConvert.convert<ReturnPolicyData>(
      json['data']);
  if (data != null) {
    returnPolicyEntity.data = data;
  }
  return returnPolicyEntity;
}

Map<String, dynamic> $ReturnPolicyEntityToJson(ReturnPolicyEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension ReturnPolicyEntityExtension on ReturnPolicyEntity {
  ReturnPolicyEntity copyWith({
    int? status,
    String? message,
    ReturnPolicyData? data,
  }) {
    return ReturnPolicyEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ReturnPolicyData $ReturnPolicyDataFromJson(Map<String, dynamic> json) {
  final ReturnPolicyData returnPolicyData = ReturnPolicyData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    returnPolicyData.id = id;
  }
  final String? policy = jsonConvert.convert<String>(json['policy']);
  if (policy != null) {
    returnPolicyData.policy = policy;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    returnPolicyData.createdAt = createdAt;
  }
  final String? returnMasterid = jsonConvert.convert<String>(
      json['return_masterid']);
  if (returnMasterid != null) {
    returnPolicyData.returnMasterid = returnMasterid;
  }
  final String? policyId = jsonConvert.convert<String>(json['policy_id']);
  if (policyId != null) {
    returnPolicyData.policyId = policyId;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    returnPolicyData.productId = productId;
  }
  final String? updatedAt = jsonConvert.convert<String>(json['updated_at']);
  if (updatedAt != null) {
    returnPolicyData.updatedAt = updatedAt;
  }
  final String? returnPolicyProductDataId = jsonConvert.convert<String>(
      json['return_policy_product_data_id']);
  if (returnPolicyProductDataId != null) {
    returnPolicyData.returnPolicyProductDataId = returnPolicyProductDataId;
  }
  return returnPolicyData;
}

Map<String, dynamic> $ReturnPolicyDataToJson(ReturnPolicyData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['policy'] = entity.policy;
  data['created_at'] = entity.createdAt;
  data['return_masterid'] = entity.returnMasterid;
  data['policy_id'] = entity.policyId;
  data['product_id'] = entity.productId;
  data['updated_at'] = entity.updatedAt;
  data['return_policy_product_data_id'] = entity.returnPolicyProductDataId;
  return data;
}

extension ReturnPolicyDataExtension on ReturnPolicyData {
  ReturnPolicyData copyWith({
    String? id,
    String? policy,
    String? createdAt,
    String? returnMasterid,
    String? policyId,
    String? productId,
    String? updatedAt,
    String? returnPolicyProductDataId,
  }) {
    return ReturnPolicyData()
      ..id = id ?? this.id
      ..policy = policy ?? this.policy
      ..createdAt = createdAt ?? this.createdAt
      ..returnMasterid = returnMasterid ?? this.returnMasterid
      ..policyId = policyId ?? this.policyId
      ..productId = productId ?? this.productId
      ..updatedAt = updatedAt ?? this.updatedAt
      ..returnPolicyProductDataId = returnPolicyProductDataId ??
          this.returnPolicyProductDataId;
  }
}