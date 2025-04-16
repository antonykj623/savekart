import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/cart_data_exist_entity.dart';

CartDataExistEntity $CartDataExistEntityFromJson(Map<String, dynamic> json) {
  final CartDataExistEntity cartDataExistEntity = CartDataExistEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    cartDataExistEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    cartDataExistEntity.message = message;
  }
  final List<CartDataExistData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CartDataExistData>(e) as CartDataExistData)
      .toList();
  if (data != null) {
    cartDataExistEntity.data = data;
  }
  return cartDataExistEntity;
}

Map<String, dynamic> $CartDataExistEntityToJson(CartDataExistEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CartDataExistEntityExtension on CartDataExistEntity {
  CartDataExistEntity copyWith({
    int? status,
    String? message,
    List<CartDataExistData>? data,
  }) {
    return CartDataExistEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CartDataExistData $CartDataExistDataFromJson(Map<String, dynamic> json) {
  final CartDataExistData cartDataExistData = CartDataExistData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    cartDataExistData.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    cartDataExistData.productId = productId;
  }
  final String? quantity = jsonConvert.convert<String>(json['quantity']);
  if (quantity != null) {
    cartDataExistData.quantity = quantity;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    cartDataExistData.userId = userId;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    cartDataExistData.status = status;
  }
  return cartDataExistData;
}

Map<String, dynamic> $CartDataExistDataToJson(CartDataExistData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['quantity'] = entity.quantity;
  data['user_id'] = entity.userId;
  data['status'] = entity.status;
  return data;
}

extension CartDataExistDataExtension on CartDataExistData {
  CartDataExistData copyWith({
    String? id,
    String? productId,
    String? quantity,
    String? userId,
    String? status,
  }) {
    return CartDataExistData()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..quantity = quantity ?? this.quantity
      ..userId = userId ?? this.userId
      ..status = status ?? this.status;
  }
}