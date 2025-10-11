import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/product_sub_category_entity.dart';
import 'package:savekart/domain/product_details_entity.dart';


ProductSubCategoryEntity $ProductSubCategoryEntityFromJson(
    Map<String, dynamic> json) {
  final ProductSubCategoryEntity productSubCategoryEntity = ProductSubCategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productSubCategoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    productSubCategoryEntity.message = message;
  }
  final List<ProductSubCategoryData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductSubCategoryData>(e) as ProductSubCategoryData)
      .toList();
  if (data != null) {
    productSubCategoryEntity.data = data;
  }
  return productSubCategoryEntity;
}

Map<String, dynamic> $ProductSubCategoryEntityToJson(
    ProductSubCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductSubCategoryEntityExtension on ProductSubCategoryEntity {
  ProductSubCategoryEntity copyWith({
    int? status,
    String? message,
    List<ProductSubCategoryData>? data,
  }) {
    return ProductSubCategoryEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ProductSubCategoryData $ProductSubCategoryDataFromJson(
    Map<String, dynamic> json) {
  final ProductSubCategoryData productSubCategoryData = ProductSubCategoryData();
  final ProductSubCategoryDataCategory? category = jsonConvert.convert<
      ProductSubCategoryDataCategory>(json['category']);
  if (category != null) {
    productSubCategoryData.category = category;
  }
  final List<ProductSubCategoryDataData>? data = (json['data'] as List<
      dynamic>?)?.map(
          (e) =>
      jsonConvert.convert<ProductSubCategoryDataData>(
          e) as ProductSubCategoryDataData).toList();
  if (data != null) {
    productSubCategoryData.data = data;
  }
  return productSubCategoryData;
}

Map<String, dynamic> $ProductSubCategoryDataToJson(
    ProductSubCategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['category'] = entity.category?.toJson();
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductSubCategoryDataExtension on ProductSubCategoryData {
  ProductSubCategoryData copyWith({
    ProductSubCategoryDataCategory? category,
    List<ProductSubCategoryDataData>? data,
  }) {
    return ProductSubCategoryData()
      ..category = category ?? this.category
      ..data = data ?? this.data;
  }
}

ProductSubCategoryDataCategory $ProductSubCategoryDataCategoryFromJson(
    Map<String, dynamic> json) {
  final ProductSubCategoryDataCategory productSubCategoryDataCategory = ProductSubCategoryDataCategory();
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    productSubCategoryDataCategory.subCategoryId = subCategoryId;
  }
  final String? subCategoryName = jsonConvert.convert<String>(
      json['sub_category_name']);
  if (subCategoryName != null) {
    productSubCategoryDataCategory.subCategoryName = subCategoryName;
  }
  return productSubCategoryDataCategory;
}

Map<String, dynamic> $ProductSubCategoryDataCategoryToJson(
    ProductSubCategoryDataCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sub_category_id'] = entity.subCategoryId;
  data['sub_category_name'] = entity.subCategoryName;
  return data;
}

extension ProductSubCategoryDataCategoryExtension on ProductSubCategoryDataCategory {
  ProductSubCategoryDataCategory copyWith({
    String? subCategoryId,
    String? subCategoryName,
  }) {
    return ProductSubCategoryDataCategory()
      ..subCategoryId = subCategoryId ?? this.subCategoryId
      ..subCategoryName = subCategoryName ?? this.subCategoryName;
  }
}

ProductSubCategoryDataData $ProductSubCategoryDataDataFromJson(
    Map<String, dynamic> json) {
  final ProductSubCategoryDataData productSubCategoryDataData = ProductSubCategoryDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productSubCategoryDataData.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    productSubCategoryDataData.productName = productName;
  }
  final String? productCode = jsonConvert.convert<String>(json['product_code']);
  if (productCode != null) {
    productSubCategoryDataData.productCode = productCode;
  }
  final String? hsncode = jsonConvert.convert<String>(json['hsncode']);
  if (hsncode != null) {
    productSubCategoryDataData.hsncode = hsncode;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    productSubCategoryDataData.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    productSubCategoryDataData.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    productSubCategoryDataData.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    productSubCategoryDataData.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    productSubCategoryDataData.primeImage = primeImage;
  }
  final String? sideImage1 = jsonConvert.convert<String>(json['side_image1']);
  if (sideImage1 != null) {
    productSubCategoryDataData.sideImage1 = sideImage1;
  }
  final String? sideImage2 = jsonConvert.convert<String>(json['side_image2']);
  if (sideImage2 != null) {
    productSubCategoryDataData.sideImage2 = sideImage2;
  }
  final dynamic sideImage3 = json['side_image3'];
  if (sideImage3 != null) {
    productSubCategoryDataData.sideImage3 = sideImage3;
  }
  final dynamic sideImage4 = json['side_image4'];
  if (sideImage4 != null) {
    productSubCategoryDataData.sideImage4 = sideImage4;
  }
  final String? unitId = jsonConvert.convert<String>(json['unit_id']);
  if (unitId != null) {
    productSubCategoryDataData.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    productSubCategoryDataData.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    productSubCategoryDataData.colorEnabled = colorEnabled;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    productSubCategoryDataData.color = color;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    productSubCategoryDataData.size = size;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    productSubCategoryDataData.vendorId = vendorId;
  }
  final String? returnPolicyId = jsonConvert.convert<String>(
      json['return_policy_id']);
  if (returnPolicyId != null) {
    productSubCategoryDataData.returnPolicyId = returnPolicyId;
  }
  final String? offeredItemStatus = jsonConvert.convert<String>(
      json['offered_item_status']);
  if (offeredItemStatus != null) {
    productSubCategoryDataData.offeredItemStatus = offeredItemStatus;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    productSubCategoryDataData.status = status;
  }
  final String? returnable = jsonConvert.convert<String>(json['returnable']);
  if (returnable != null) {
    productSubCategoryDataData.returnable = returnable;
  }
  final String? returnDays = jsonConvert.convert<String>(json['return_days']);
  if (returnDays != null) {
    productSubCategoryDataData.returnDays = returnDays;
  }
  final String? upd = jsonConvert.convert<String>(json['upd']);
  if (upd != null) {
    productSubCategoryDataData.upd = upd;
  }
  final String? current_qty = jsonConvert.convert<String>(json['current_qty']);
  if (upd != null) {
    productSubCategoryDataData.currentQty = current_qty;
  }

  return productSubCategoryDataData;
}

Map<String, dynamic> $ProductSubCategoryDataDataToJson(
    ProductSubCategoryDataData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_name'] = entity.productName;
  data['product_code'] = entity.productCode;
  data['hsncode'] = entity.hsncode;
  data['category_id'] = entity.categoryId;
  data['sub_category_id'] = entity.subCategoryId;
  data['product_description'] = entity.productDescription;
  data['product_spec'] = entity.productSpec;
  data['prime_image'] = entity.primeImage;
  data['side_image1'] = entity.sideImage1;
  data['side_image2'] = entity.sideImage2;
  data['side_image3'] = entity.sideImage3;
  data['side_image4'] = entity.sideImage4;
  data['unit_id'] = entity.unitId;
  data['size_enabled'] = entity.sizeEnabled;
  data['color_enabled'] = entity.colorEnabled;
  data['color'] = entity.color;
  data['size'] = entity.size;
  data['vendor_id'] = entity.vendorId;
  data['return_policy_id'] = entity.returnPolicyId;
  data['offered_item_status'] = entity.offeredItemStatus;
  data['status'] = entity.status;
  data['returnable'] = entity.returnable;
  data['return_days'] = entity.returnDays;
  data['upd'] = entity.upd;
  data['current_qty']=entity.currentQty;
  return data;
}

extension ProductSubCategoryDataDataExtension on ProductSubCategoryDataData {
  ProductSubCategoryDataData copyWith({
    String? id,
    String? productName,
    String? productCode,
    String? hsncode,
    String? categoryId,
    String? subCategoryId,
    String? productDescription,
    String? productSpec,
    String? primeImage,
    String? sideImage1,
    String? sideImage2,
    dynamic sideImage3,
    dynamic sideImage4,
    String? unitId,
    String? sizeEnabled,
    String? colorEnabled,
    String? color,
    String? size,
    String? vendorId,
    String? returnPolicyId,
    String? offeredItemStatus,
    String? status,
    String? returnable,
    String? returnDays,
    String? upd,
    String? currentQty
  }) {
    return ProductSubCategoryDataData()
      ..id = id ?? this.id
      ..productName = productName ?? this.productName
      ..productCode = productCode ?? this.productCode
      ..hsncode = hsncode ?? this.hsncode
      ..categoryId = categoryId ?? this.categoryId
      ..subCategoryId = subCategoryId ?? this.subCategoryId
      ..productDescription = productDescription ?? this.productDescription
      ..productSpec = productSpec ?? this.productSpec
      ..primeImage = primeImage ?? this.primeImage
      ..sideImage1 = sideImage1 ?? this.sideImage1
      ..sideImage2 = sideImage2 ?? this.sideImage2
      ..sideImage3 = sideImage3 ?? this.sideImage3
      ..sideImage4 = sideImage4 ?? this.sideImage4
      ..unitId = unitId ?? this.unitId
      ..sizeEnabled = sizeEnabled ?? this.sizeEnabled
      ..colorEnabled = colorEnabled ?? this.colorEnabled
      ..color = color ?? this.color
      ..size = size ?? this.size
      ..vendorId = vendorId ?? this.vendorId
      ..returnPolicyId = returnPolicyId ?? this.returnPolicyId
      ..offeredItemStatus = offeredItemStatus ?? this.offeredItemStatus
      ..status = status ?? this.status
      ..returnable = returnable ?? this.returnable
      ..returnDays = returnDays ?? this.returnDays
      ..upd = upd ?? this.upd
      ..currentQty=currentQty?? this.currentQty;
  }
}