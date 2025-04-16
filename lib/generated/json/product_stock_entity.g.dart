import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/product_stock_entity.dart';

ProductStockEntity $ProductStockEntityFromJson(Map<String, dynamic> json) {
  final ProductStockEntity productStockEntity = ProductStockEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productStockEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    productStockEntity.message = message;
  }
  final ProductStockData? data = jsonConvert.convert<ProductStockData>(
      json['data']);
  if (data != null) {
    productStockEntity.data = data;
  }
  return productStockEntity;
}

Map<String, dynamic> $ProductStockEntityToJson(ProductStockEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension ProductStockEntityExtension on ProductStockEntity {
  ProductStockEntity copyWith({
    int? status,
    String? message,
    ProductStockData? data,
  }) {
    return ProductStockEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ProductStockData $ProductStockDataFromJson(Map<String, dynamic> json) {
  final ProductStockData productStockData = ProductStockData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productStockData.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    productStockData.productId = productId;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    productStockData.vendorId = vendorId;
  }
  final String? currentQty = jsonConvert.convert<String>(json['current_qty']);
  if (currentQty != null) {
    productStockData.currentQty = currentQty;
  }
  final String? priceStock = jsonConvert.convert<String>(json['price_stock']);
  if (priceStock != null) {
    productStockData.priceStock = priceStock;
  }
  final String? mrp = jsonConvert.convert<String>(json['mrp']);
  if (mrp != null) {
    productStockData.mrp = mrp;
  }
  final String? savecartPrice = jsonConvert.convert<String>(
      json['savecart_price']);
  if (savecartPrice != null) {
    productStockData.savecartPrice = savecartPrice;
  }
  final String? ppRedemption = jsonConvert.convert<String>(
      json['pp_redemption']);
  if (ppRedemption != null) {
    productStockData.ppRedemption = ppRedemption;
  }
  final String? priceSales = jsonConvert.convert<String>(json['price_sales']);
  if (priceSales != null) {
    productStockData.priceSales = priceSales;
  }
  final String? igst = jsonConvert.convert<String>(json['igst']);
  if (igst != null) {
    productStockData.igst = igst;
  }
  final String? sgst = jsonConvert.convert<String>(json['sgst']);
  if (sgst != null) {
    productStockData.sgst = sgst;
  }
  final String? csgt = jsonConvert.convert<String>(json['csgt']);
  if (csgt != null) {
    productStockData.csgt = csgt;
  }
  final String? igstAmt = jsonConvert.convert<String>(json['igst_amt']);
  if (igstAmt != null) {
    productStockData.igstAmt = igstAmt;
  }
  final String? sgstAmt = jsonConvert.convert<String>(json['sgst_amt']);
  if (sgstAmt != null) {
    productStockData.sgstAmt = sgstAmt;
  }
  final String? cgstAmt = jsonConvert.convert<String>(json['cgst_amt']);
  if (cgstAmt != null) {
    productStockData.cgstAmt = cgstAmt;
  }
  final String? priceWithoutGst = jsonConvert.convert<String>(
      json['price_without_gst']);
  if (priceWithoutGst != null) {
    productStockData.priceWithoutGst = priceWithoutGst;
  }
  final String? margin = jsonConvert.convert<String>(json['margin']);
  if (margin != null) {
    productStockData.margin = margin;
  }
  final String? genShareAmt = jsonConvert.convert<String>(
      json['gen_share_amt']);
  if (genShareAmt != null) {
    productStockData.genShareAmt = genShareAmt;
  }
  final String? cashBack = jsonConvert.convert<String>(json['cash_back']);
  if (cashBack != null) {
    productStockData.cashBack = cashBack;
  }
  final String? stockEntryDate = jsonConvert.convert<String>(
      json['stock_entry_date']);
  if (stockEntryDate != null) {
    productStockData.stockEntryDate = stockEntryDate;
  }
  return productStockData;
}

Map<String, dynamic> $ProductStockDataToJson(ProductStockData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['vendor_id'] = entity.vendorId;
  data['current_qty'] = entity.currentQty;
  data['price_stock'] = entity.priceStock;
  data['mrp'] = entity.mrp;
  data['savecart_price'] = entity.savecartPrice;
  data['pp_redemption'] = entity.ppRedemption;
  data['price_sales'] = entity.priceSales;
  data['igst'] = entity.igst;
  data['sgst'] = entity.sgst;
  data['csgt'] = entity.csgt;
  data['igst_amt'] = entity.igstAmt;
  data['sgst_amt'] = entity.sgstAmt;
  data['cgst_amt'] = entity.cgstAmt;
  data['price_without_gst'] = entity.priceWithoutGst;
  data['margin'] = entity.margin;
  data['gen_share_amt'] = entity.genShareAmt;
  data['cash_back'] = entity.cashBack;
  data['stock_entry_date'] = entity.stockEntryDate;
  return data;
}

extension ProductStockDataExtension on ProductStockData {
  ProductStockData copyWith({
    String? id,
    String? productId,
    String? vendorId,
    String? currentQty,
    String? priceStock,
    String? mrp,
    String? savecartPrice,
    String? ppRedemption,
    String? priceSales,
    String? igst,
    String? sgst,
    String? csgt,
    String? igstAmt,
    String? sgstAmt,
    String? cgstAmt,
    String? priceWithoutGst,
    String? margin,
    String? genShareAmt,
    String? cashBack,
    String? stockEntryDate,
  }) {
    return ProductStockData()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..vendorId = vendorId ?? this.vendorId
      ..currentQty = currentQty ?? this.currentQty
      ..priceStock = priceStock ?? this.priceStock
      ..mrp = mrp ?? this.mrp
      ..savecartPrice = savecartPrice ?? this.savecartPrice
      ..ppRedemption = ppRedemption ?? this.ppRedemption
      ..priceSales = priceSales ?? this.priceSales
      ..igst = igst ?? this.igst
      ..sgst = sgst ?? this.sgst
      ..csgt = csgt ?? this.csgt
      ..igstAmt = igstAmt ?? this.igstAmt
      ..sgstAmt = sgstAmt ?? this.sgstAmt
      ..cgstAmt = cgstAmt ?? this.cgstAmt
      ..priceWithoutGst = priceWithoutGst ?? this.priceWithoutGst
      ..margin = margin ?? this.margin
      ..genShareAmt = genShareAmt ?? this.genShareAmt
      ..cashBack = cashBack ?? this.cashBack
      ..stockEntryDate = stockEntryDate ?? this.stockEntryDate;
  }
}