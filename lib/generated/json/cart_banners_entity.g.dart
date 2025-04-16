import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/cart_banners_entity.dart';

CartBannersEntity $CartBannersEntityFromJson(Map<String, dynamic> json) {
  final CartBannersEntity cartBannersEntity = CartBannersEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    cartBannersEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    cartBannersEntity.message = message;
  }
  final List<CartBannersData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CartBannersData>(e) as CartBannersData)
      .toList();
  if (data != null) {
    cartBannersEntity.data = data;
  }
  return cartBannersEntity;
}

Map<String, dynamic> $CartBannersEntityToJson(CartBannersEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CartBannersEntityExtension on CartBannersEntity {
  CartBannersEntity copyWith({
    int? status,
    String? message,
    List<CartBannersData>? data,
  }) {
    return CartBannersEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CartBannersData $CartBannersDataFromJson(Map<String, dynamic> json) {
  final CartBannersData cartBannersData = CartBannersData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    cartBannersData.id = id;
  }
  final String? imageFile = jsonConvert.convert<String>(json['image_file']);
  if (imageFile != null) {
    cartBannersData.imageFile = imageFile;
  }
  final String? orderNumber = jsonConvert.convert<String>(json['order_number']);
  if (orderNumber != null) {
    cartBannersData.orderNumber = orderNumber;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    cartBannersData.status = status;
  }
  return cartBannersData;
}

Map<String, dynamic> $CartBannersDataToJson(CartBannersData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['image_file'] = entity.imageFile;
  data['order_number'] = entity.orderNumber;
  data['status'] = entity.status;
  return data;
}

extension CartBannersDataExtension on CartBannersData {
  CartBannersData copyWith({
    String? id,
    String? imageFile,
    String? orderNumber,
    String? status,
  }) {
    return CartBannersData()
      ..id = id ?? this.id
      ..imageFile = imageFile ?? this.imageFile
      ..orderNumber = orderNumber ?? this.orderNumber
      ..status = status ?? this.status;
  }
}