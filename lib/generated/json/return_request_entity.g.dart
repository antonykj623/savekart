import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/return_request_entity.dart';

ReturnRequestEntity $ReturnRequestEntityFromJson(Map<String, dynamic> json) {
  final ReturnRequestEntity returnRequestEntity = ReturnRequestEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    returnRequestEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    returnRequestEntity.message = message;
  }
  final List<ReturnRequestData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<ReturnRequestData>(e) as ReturnRequestData)
      .toList();
  if (data != null) {
    returnRequestEntity.data = data;
  }
  return returnRequestEntity;
}

Map<String, dynamic> $ReturnRequestEntityToJson(ReturnRequestEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ReturnRequestEntityExtension on ReturnRequestEntity {
  ReturnRequestEntity copyWith({
    int? status,
    String? message,
    List<ReturnRequestData>? data,
  }) {
    return ReturnRequestEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ReturnRequestData $ReturnRequestDataFromJson(Map<String, dynamic> json) {
  final ReturnRequestData returnRequestData = ReturnRequestData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    returnRequestData.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    returnRequestData.productId = productId;
  }
  final String? productReturnPolicyId = jsonConvert.convert<String>(
      json['product_return_policy_id']);
  if (productReturnPolicyId != null) {
    returnRequestData.productReturnPolicyId = productReturnPolicyId;
  }
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    returnRequestData.orderId = orderId;
  }
  final String? image1 = jsonConvert.convert<String>(json['image1']);
  if (image1 != null) {
    returnRequestData.image1 = image1;
  }
  final String? image2 = jsonConvert.convert<String>(json['image2']);
  if (image2 != null) {
    returnRequestData.image2 = image2;
  }
  final String? image3 = jsonConvert.convert<String>(json['image3']);
  if (image3 != null) {
    returnRequestData.image3 = image3;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    returnRequestData.userId = userId;
  }
  final String? reason = jsonConvert.convert<String>(json['reason']);
  if (reason != null) {
    returnRequestData.reason = reason;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    returnRequestData.createdAt = createdAt;
  }
  final dynamic refundedDate = json['refunded_date'];
  if (refundedDate != null) {
    returnRequestData.refundedDate = refundedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    returnRequestData.status = status;
  }
  final String? refundStatus = jsonConvert.convert<String>(
      json['refund_status']);
  if (refundStatus != null) {
    returnRequestData.refundStatus = refundStatus;
  }
  return returnRequestData;
}

Map<String, dynamic> $ReturnRequestDataToJson(ReturnRequestData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['product_return_policy_id'] = entity.productReturnPolicyId;
  data['order_id'] = entity.orderId;
  data['image1'] = entity.image1;
  data['image2'] = entity.image2;
  data['image3'] = entity.image3;
  data['user_id'] = entity.userId;
  data['reason'] = entity.reason;
  data['created_at'] = entity.createdAt;
  data['refunded_date'] = entity.refundedDate;
  data['status'] = entity.status;
  data['refund_status'] = entity.refundStatus;
  return data;
}

extension ReturnRequestDataExtension on ReturnRequestData {
  ReturnRequestData copyWith({
    String? id,
    String? productId,
    String? productReturnPolicyId,
    String? orderId,
    String? image1,
    String? image2,
    String? image3,
    String? userId,
    String? reason,
    String? createdAt,
    dynamic refundedDate,
    String? status,
    String? refundStatus,
  }) {
    return ReturnRequestData()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..productReturnPolicyId = productReturnPolicyId ??
          this.productReturnPolicyId
      ..orderId = orderId ?? this.orderId
      ..image1 = image1 ?? this.image1
      ..image2 = image2 ?? this.image2
      ..image3 = image3 ?? this.image3
      ..userId = userId ?? this.userId
      ..reason = reason ?? this.reason
      ..createdAt = createdAt ?? this.createdAt
      ..refundedDate = refundedDate ?? this.refundedDate
      ..status = status ?? this.status
      ..refundStatus = refundStatus ?? this.refundStatus;
  }
}