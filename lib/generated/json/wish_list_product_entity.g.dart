import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/wish_list_product_entity.dart';

WishListProductEntity $WishListProductEntityFromJson(
    Map<String, dynamic> json) {
  final WishListProductEntity wishListProductEntity = WishListProductEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    wishListProductEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    wishListProductEntity.message = message;
  }
  final List<WishListProductData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<WishListProductData>(e) as WishListProductData)
      .toList();
  if (data != null) {
    wishListProductEntity.data = data;
  }
  return wishListProductEntity;
}

Map<String, dynamic> $WishListProductEntityToJson(
    WishListProductEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension WishListProductEntityExtension on WishListProductEntity {
  WishListProductEntity copyWith({
    int? status,
    String? message,
    List<WishListProductData>? data,
  }) {
    return WishListProductEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

WishListProductData $WishListProductDataFromJson(Map<String, dynamic> json) {
  final WishListProductData wishListProductData = WishListProductData();
  final String? wishlistid = jsonConvert.convert<String>(json['wishlistid']);
  if (wishlistid != null) {
    wishListProductData.wishlistid = wishlistid;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    wishListProductData.price = price;
  }
  final String? stockid = jsonConvert.convert<String>(json['stockid']);
  if (stockid != null) {
    wishListProductData.stockid = stockid;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    wishListProductData.productName = productName;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    wishListProductData.primeImage = primeImage;
  }
  return wishListProductData;
}

Map<String, dynamic> $WishListProductDataToJson(WishListProductData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['wishlistid'] = entity.wishlistid;
  data['price'] = entity.price;
  data['stockid'] = entity.stockid;
  data['product_name'] = entity.productName;
  data['prime_image'] = entity.primeImage;
  return data;
}

extension WishListProductDataExtension on WishListProductData {
  WishListProductData copyWith({
    String? wishlistid,
    String? price,
    String? stockid,
    String? productName,
    String? primeImage,
  }) {
    return WishListProductData()
      ..wishlistid = wishlistid ?? this.wishlistid
      ..price = price ?? this.price
      ..stockid = stockid ?? this.stockid
      ..productName = productName ?? this.productName
      ..primeImage = primeImage ?? this.primeImage;
  }
}