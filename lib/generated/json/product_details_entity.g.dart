import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/product_details_entity.dart';

ProductDetailsEntity $ProductDetailsEntityFromJson(Map<String, dynamic> json) {
  final ProductDetailsEntity productDetailsEntity = ProductDetailsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productDetailsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    productDetailsEntity.message = message;
  }
  final List<ProductDetailsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductDetailsData>(e) as ProductDetailsData)
      .toList();
  if (data != null) {
    productDetailsEntity.data = data;
  }
  return productDetailsEntity;
}

Map<String, dynamic> $ProductDetailsEntityToJson(ProductDetailsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductDetailsEntityExtension on ProductDetailsEntity {
  ProductDetailsEntity copyWith({
    int? status,
    String? message,
    List<ProductDetailsData>? data,
  }) {
    return ProductDetailsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ProductDetailsData $ProductDetailsDataFromJson(Map<String, dynamic> json) {
  final ProductDetailsData productDetailsData = ProductDetailsData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productDetailsData.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    productDetailsData.productName = productName;
  }
  final String? productCode = jsonConvert.convert<String>(json['product_code']);
  if (productCode != null) {
    productDetailsData.productCode = productCode;
  }
  final String? hsncode = jsonConvert.convert<String>(json['hsncode']);
  if (hsncode != null) {
    productDetailsData.hsncode = hsncode;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    productDetailsData.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    productDetailsData.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    productDetailsData.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    productDetailsData.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    productDetailsData.primeImage = primeImage;
  }
  final dynamic sideImage1 = json['side_image1'];
  if (sideImage1 != null) {
    productDetailsData.sideImage1 = sideImage1;
  }
  final dynamic sideImage2 = json['side_image2'];
  if (sideImage2 != null) {
    productDetailsData.sideImage2 = sideImage2;
  }
  final dynamic sideImage3 = json['side_image3'];
  if (sideImage3 != null) {
    productDetailsData.sideImage3 = sideImage3;
  }
  final dynamic sideImage4 = json['side_image4'];
  if (sideImage4 != null) {
    productDetailsData.sideImage4 = sideImage4;
  }
  final String? unitId = jsonConvert.convert<String>(json['unit_id']);
  if (unitId != null) {
    productDetailsData.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    productDetailsData.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    productDetailsData.colorEnabled = colorEnabled;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    productDetailsData.color = color;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    productDetailsData.size = size;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    productDetailsData.vendorId = vendorId;
  }
  final String? returnPolicyId = jsonConvert.convert<String>(
      json['return_policy_id']);
  if (returnPolicyId != null) {
    productDetailsData.returnPolicyId = returnPolicyId;
  }
  final String? offeredItemStatus = jsonConvert.convert<String>(
      json['offered_item_status']);
  if (offeredItemStatus != null) {
    productDetailsData.offeredItemStatus = offeredItemStatus;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    productDetailsData.status = status;
  }
  final String? returnable = jsonConvert.convert<String>(json['returnable']);
  if (returnable != null) {
    productDetailsData.returnable = returnable;
  }
  final String? returnDays = jsonConvert.convert<String>(json['return_days']);
  if (returnDays != null) {
    productDetailsData.returnDays = returnDays;
  }
  final String? upd = jsonConvert.convert<String>(json['upd']);
  if (upd != null) {
    productDetailsData.upd = upd;
  }
  return productDetailsData;
}

Map<String, dynamic> $ProductDetailsDataToJson(ProductDetailsData entity) {
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
  return data;
}

extension ProductDetailsDataExtension on ProductDetailsData {
  ProductDetailsData copyWith({
    String? id,
    String? productName,
    String? productCode,
    String? hsncode,
    String? categoryId,
    String? subCategoryId,
    String? productDescription,
    String? productSpec,
    String? primeImage,
    dynamic sideImage1,
    dynamic sideImage2,
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
  }) {
    return ProductDetailsData()
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
      ..upd = upd ?? this.upd;
  }
}