import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/cart_products_entity.dart';

CartProductsEntity $CartProductsEntityFromJson(Map<String, dynamic> json) {
  final CartProductsEntity cartProductsEntity = CartProductsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    cartProductsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    cartProductsEntity.message = message;
  }
  final List<CartProductsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CartProductsData>(e) as CartProductsData)
      .toList();
  if (data != null) {
    cartProductsEntity.data = data;
  }
  return cartProductsEntity;
}

Map<String, dynamic> $CartProductsEntityToJson(CartProductsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CartProductsEntityExtension on CartProductsEntity {
  CartProductsEntity copyWith({
    int? status,
    String? message,
    List<CartProductsData>? data,
  }) {
    return CartProductsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CartProductsData $CartProductsDataFromJson(Map<String, dynamic> json) {
  final CartProductsData cartProductsData = CartProductsData();
  final String? cartid = jsonConvert.convert<String>(json['cartid']);
  if (cartid != null) {
    cartProductsData.cartid = cartid;
  }
  final String? ppredemption = jsonConvert.convert<String>(
      json['ppredemption']);
  if (ppredemption != null) {
    cartProductsData.ppredemption = ppredemption;
  }
  final String? quantity = jsonConvert.convert<String>(json['quantity']);
  if (quantity != null) {
    cartProductsData.quantity = quantity;
  }
  final String? pointsRedeemed = jsonConvert.convert<String>(
      json['points_redeemed']);
  if (pointsRedeemed != null) {
    cartProductsData.pointsRedeemed = pointsRedeemed;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    cartProductsData.price = price;
  }
  final String? savekartprice = jsonConvert.convert<String>(
      json['savekartprice']);
  if (savekartprice != null) {
    cartProductsData.savekartprice = savekartprice;
  }
  final String? stockid = jsonConvert.convert<String>(json['stockid']);
  if (stockid != null) {
    cartProductsData.stockid = stockid;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    cartProductsData.productName = productName;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    cartProductsData.primeImage = primeImage;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    cartProductsData.size = size;
  }
  final String? current_qty = jsonConvert.convert<String>(json['current_qty']);
  if (current_qty != null) {
    cartProductsData.current_qty = current_qty;
  }
  return cartProductsData;
}

Map<String, dynamic> $CartProductsDataToJson(CartProductsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cartid'] = entity.cartid;
  data['ppredemption'] = entity.ppredemption;
  data['quantity'] = entity.quantity;
  data['points_redeemed'] = entity.pointsRedeemed;
  data['price'] = entity.price;
  data['savekartprice'] = entity.savekartprice;
  data['stockid'] = entity.stockid;
  data['product_name'] = entity.productName;
  data['prime_image'] = entity.primeImage;
  data['size'] = entity.size;
  data['current_qty'] = entity.current_qty;
  return data;
}

extension CartProductsDataExtension on CartProductsData {
  CartProductsData copyWith({
    String? cartid,
    String? ppredemption,
    String? quantity,
    String? pointsRedeemed,
    String? price,
    String? savekartprice,
    String? stockid,
    String? productName,
    String? primeImage,
    String? size,
    String? current_qty,
  }) {
    return CartProductsData()
      ..cartid = cartid ?? this.cartid
      ..ppredemption = ppredemption ?? this.ppredemption
      ..quantity = quantity ?? this.quantity
      ..pointsRedeemed = pointsRedeemed ?? this.pointsRedeemed
      ..price = price ?? this.price
      ..savekartprice = savekartprice ?? this.savekartprice
      ..stockid = stockid ?? this.stockid
      ..productName = productName ?? this.productName
      ..primeImage = primeImage ?? this.primeImage
      ..size = size ?? this.size
      ..current_qty = current_qty ?? this.current_qty;
  }
}