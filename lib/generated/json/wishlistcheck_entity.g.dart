import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/wishlistcheck_entity.dart';

WishlistcheckEntity $WishlistcheckEntityFromJson(Map<String, dynamic> json) {
  final WishlistcheckEntity wishlistcheckEntity = WishlistcheckEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    wishlistcheckEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    wishlistcheckEntity.message = message;
  }
  final List<WishlistcheckData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<WishlistcheckData>(e) as WishlistcheckData)
      .toList();
  if (data != null) {
    wishlistcheckEntity.data = data;
  }
  return wishlistcheckEntity;
}

Map<String, dynamic> $WishlistcheckEntityToJson(WishlistcheckEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension WishlistcheckEntityExtension on WishlistcheckEntity {
  WishlistcheckEntity copyWith({
    int? status,
    String? message,
    List<WishlistcheckData>? data,
  }) {
    return WishlistcheckEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WishlistcheckData $WishlistcheckDataFromJson(Map<String, dynamic> json) {
  final WishlistcheckData wishlistcheckData = WishlistcheckData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    wishlistcheckData.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    wishlistcheckData.productId = productId;
  }
  final String? productStockId = jsonConvert.convert<String>(
      json['product_stock_id']);
  if (productStockId != null) {
    wishlistcheckData.productStockId = productStockId;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    wishlistcheckData.userId = userId;
  }
  return wishlistcheckData;
}

Map<String, dynamic> $WishlistcheckDataToJson(WishlistcheckData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['product_stock_id'] = entity.productStockId;
  data['user_id'] = entity.userId;
  return data;
}

extension WishlistcheckDataExtension on WishlistcheckData {
  WishlistcheckData copyWith({
    String? id,
    String? productId,
    String? productStockId,
    String? userId,
  }) {
    return WishlistcheckData()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..productStockId = productStockId ?? this.productStockId
      ..userId = userId ?? this.userId;
  }
}