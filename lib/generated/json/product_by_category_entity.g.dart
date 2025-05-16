import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/product_by_category_entity.dart';

ProductByCategoryEntity $ProductByCategoryEntityFromJson(
    Map<String, dynamic> json) {
  final ProductByCategoryEntity productByCategoryEntity = ProductByCategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    productByCategoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    productByCategoryEntity.message = message;
  }
  final List<ProductByCategoryData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductByCategoryData>(e) as ProductByCategoryData)
      .toList();
  if (data != null) {
    productByCategoryEntity.data = data;
  }
  return productByCategoryEntity;
}

Map<String, dynamic> $ProductByCategoryEntityToJson(
    ProductByCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductByCategoryEntityExtension on ProductByCategoryEntity {
  ProductByCategoryEntity copyWith({
    int? status,
    String? message,
    List<ProductByCategoryData>? data,
  }) {
    return ProductByCategoryEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

ProductByCategoryData $ProductByCategoryDataFromJson(
    Map<String, dynamic> json) {
  final ProductByCategoryData productByCategoryData = ProductByCategoryData();
  final ProductByCategoryDataCategory? category = jsonConvert.convert<
      ProductByCategoryDataCategory>(json['category']);
  if (category != null) {
    productByCategoryData.category = category;
  }
  final List<ProductByCategoryDataData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<ProductByCategoryDataData>(
          e) as ProductByCategoryDataData)
      .toList();
  if (data != null) {
    productByCategoryData.data = data;
  }
  return productByCategoryData;
}

Map<String, dynamic> $ProductByCategoryDataToJson(
    ProductByCategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['category'] = entity.category?.toJson();
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension ProductByCategoryDataExtension on ProductByCategoryData {
  ProductByCategoryData copyWith({
    ProductByCategoryDataCategory? category,
    List<ProductByCategoryDataData>? data,
  }) {
    return ProductByCategoryData()
      ..category = category ?? this.category
      ..data = data ?? this.data;
  }
}

ProductByCategoryDataCategory $ProductByCategoryDataCategoryFromJson(
    Map<String, dynamic> json) {
  final ProductByCategoryDataCategory productByCategoryDataCategory = ProductByCategoryDataCategory();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productByCategoryDataCategory.id = id;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['category_name']);
  if (categoryName != null) {
    productByCategoryDataCategory.categoryName = categoryName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    productByCategoryDataCategory.status = status;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    productByCategoryDataCategory.image = image;
  }
  return productByCategoryDataCategory;
}

Map<String, dynamic> $ProductByCategoryDataCategoryToJson(
    ProductByCategoryDataCategory entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['category_name'] = entity.categoryName;
  data['status'] = entity.status;
  data['image'] = entity.image;
  return data;
}

extension ProductByCategoryDataCategoryExtension on ProductByCategoryDataCategory {
  ProductByCategoryDataCategory copyWith({
    String? id,
    String? categoryName,
    String? status,
    String? image,
  }) {
    return ProductByCategoryDataCategory()
      ..id = id ?? this.id
      ..categoryName = categoryName ?? this.categoryName
      ..status = status ?? this.status
      ..image = image ?? this.image;
  }
}

ProductByCategoryDataData $ProductByCategoryDataDataFromJson(
    Map<String, dynamic> json) {
  final ProductByCategoryDataData productByCategoryDataData = ProductByCategoryDataData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    productByCategoryDataData.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    productByCategoryDataData.productName = productName;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    productByCategoryDataData.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    productByCategoryDataData.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    productByCategoryDataData.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    productByCategoryDataData.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    productByCategoryDataData.primeImage = primeImage;
  }
  final String? sideImage1 = jsonConvert.convert<String>(json['side_image1']);
  if (sideImage1 != null) {
    productByCategoryDataData.sideImage1 = sideImage1;
  }
  final String? sideImage2 = jsonConvert.convert<String>(json['side_image2']);
  if (sideImage2 != null) {
    productByCategoryDataData.sideImage2 = sideImage2;
  }
  final String? sideImage3 = jsonConvert.convert<String>(json['side_image3']);
  if (sideImage3 != null) {
    productByCategoryDataData.sideImage3 = sideImage3;
  }
  final String? sideImage4 = jsonConvert.convert<String>(json['side_image4']);
  if (sideImage4 != null) {
    productByCategoryDataData.sideImage4 = sideImage4;
  }
  final dynamic unitId = json['unit_id'];
  if (unitId != null) {
    productByCategoryDataData.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    productByCategoryDataData.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    productByCategoryDataData.colorEnabled = colorEnabled;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    productByCategoryDataData.color = color;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    productByCategoryDataData.size = size;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    productByCategoryDataData.vendorId = vendorId;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    productByCategoryDataData.status = status;
  }
  final String? returnDays = jsonConvert.convert<String>(json['return_days']);
  if (returnDays != null) {
    productByCategoryDataData.returnDays = returnDays;
  }
  final String? productCode = jsonConvert.convert<String>(json['product_code']);
  if (productCode != null) {
    productByCategoryDataData.productCode = productCode;
  }




  return productByCategoryDataData;
}

Map<String, dynamic> $ProductByCategoryDataDataToJson(
    ProductByCategoryDataData entity) {
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
  data['status'] = entity.status;
  data['return_days'] = entity.returnDays;
  data['product_code']=entity.productCode;

  return data;
}

extension ProductByCategoryDataDataExtension on ProductByCategoryDataData {
  ProductByCategoryDataData copyWith({
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
    dynamic unitId,
    String? sizeEnabled,
    String? colorEnabled,
    String? color,
    String? size,
    String? vendorId,
    String? status,
    String? returnDays,
    String? productCode
  }) {
    return ProductByCategoryDataData()
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
      ..status = status ?? this.status
      ..returnDays=returnDays ?? this.returnDays
      ..productCode=productCode ?? this.productCode

    ;
  }
}