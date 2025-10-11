import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/products_entity.dart';

ProductsEntity $ProductsEntityFromJson(Map<String, dynamic> json) {
  final ProductsEntity productsEntity = ProductsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    productsEntity.message = message;
  }
  final List<ProductsData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<ProductsData>(e) as ProductsData).toList();
  if (data != null) {
    productsEntity.data = data;
  }
  return productsEntity;
}

Map<String, dynamic> $ProductsEntityToJson(ProductsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductsEntityExtension on ProductsEntity {
  ProductsEntity copyWith({
    int? status,
    String? message,
    List<ProductsData>? data,
  }) {
    return ProductsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ProductsData $ProductsDataFromJson(Map<String, dynamic> json) {
  final ProductsData productsData = ProductsData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productsData.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    productsData.productName = productName;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    productsData.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    productsData.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    productsData.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    productsData.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    productsData.primeImage = primeImage;
  }
  final String? sideImage1 = jsonConvert.convert<String>(json['side_image1']);
  if (sideImage1 != null) {
    productsData.sideImage1 = sideImage1;
  }
  final String? sideImage2 = jsonConvert.convert<String>(json['side_image2']);
  if (sideImage2 != null) {
    productsData.sideImage2 = sideImage2;
  }
  final String? sideImage3 = jsonConvert.convert<String>(json['side_image3']);
  if (sideImage3 != null) {
    productsData.sideImage3 = sideImage3;
  }
  final String? sideImage4 = jsonConvert.convert<String>(json['side_image4']);
  if (sideImage4 != null) {
    productsData.sideImage4 = sideImage4;
  }
  final String? unitId = jsonConvert.convert<String>(json['unit_id']);
  if (unitId != null) {
    productsData.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    productsData.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    productsData.colorEnabled = colorEnabled;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    productsData.color = color;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    productsData.size = size;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    productsData.vendorId = vendorId;
  }
  final String? returnPolicyId = jsonConvert.convert<String>(
      json['return_policy_id']);
  if (returnPolicyId != null) {
    productsData.returnPolicyId = returnPolicyId;
  }
  final String? offeredItemStatus = jsonConvert.convert<String>(
      json['offered_item_status']);
  if (offeredItemStatus != null) {
    productsData.offeredItemStatus = offeredItemStatus;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    productsData.status = status;
  }
  final String? returnable = jsonConvert.convert<String>(json['returnable']);
  if (returnable != null) {
    productsData.returnable = returnable;
  }
  final String? productCode = jsonConvert.convert<String>(json['product_code']);
  if (productCode != null) {
    productsData.productCode = productCode;
  }

  final String? currentQty = jsonConvert.convert<String>(json['current_qty']);
  if (currentQty != null) {
    productsData.currentQty = currentQty;
  }


  return productsData;
}

Map<String, dynamic> $ProductsDataToJson(ProductsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_name'] = entity.productName;
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
  data['product_code'] = entity.productCode;
  data['current_qty']=entity.currentQty;
  return data;
}

extension ProductsDataExtension on ProductsData {
  ProductsData copyWith({
    String? id,
    String? productName,
    String? categoryId,
    String? subCategoryId,
    String? productDescription,
    String? productSpec,
    String? primeImage,
    String? sideImage1,
    String? sideImage2,
    String? sideImage3,
    String? sideImage4,
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
    String? productCode,
    String? currentQty
  }) {
    return ProductsData()
      ..id = id ?? this.id
      ..productName = productName ?? this.productName
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
      ..productCode = productCode ?? this.productCode
      ..currentQty=currentQty?? this.currentQty;
  }
}