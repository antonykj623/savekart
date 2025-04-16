import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/category_entity.dart';

CategoryEntity $CategoryEntityFromJson(Map<String, dynamic> json) {
  final CategoryEntity categoryEntity = CategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    categoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    categoryEntity.message = message;
  }
  final List<CategoryData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<CategoryData>(e) as CategoryData).toList();
  if (data != null) {
    categoryEntity.data = data;
  }
  return categoryEntity;
}

Map<String, dynamic> $CategoryEntityToJson(CategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CategoryEntityExtension on CategoryEntity {
  CategoryEntity copyWith({
    int? status,
    String? message,
    List<CategoryData>? data,
  }) {
    return CategoryEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CategoryData $CategoryDataFromJson(Map<String, dynamic> json) {
  final CategoryData categoryData = CategoryData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    categoryData.id = id;
  }
  final String? categoryName = jsonConvert.convert<String>(
      json['category_name']);
  if (categoryName != null) {
    categoryData.categoryName = categoryName;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    categoryData.status = status;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    categoryData.image = image;
  }
  return categoryData;
}

Map<String, dynamic> $CategoryDataToJson(CategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['category_name'] = entity.categoryName;
  data['status'] = entity.status;
  data['image'] = entity.image;
  return data;
}

extension CategoryDataExtension on CategoryData {
  CategoryData copyWith({
    String? id,
    String? categoryName,
    String? status,
    String? image,
  }) {
    return CategoryData()
      ..id = id ?? this.id
      ..categoryName = categoryName ?? this.categoryName
      ..status = status ?? this.status
      ..image = image ?? this.image;
  }
}