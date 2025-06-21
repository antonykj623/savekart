import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/subcategory_entity.dart';

SubcategoryEntity $SubcategoryEntityFromJson(Map<String, dynamic> json) {
  final SubcategoryEntity subcategoryEntity = SubcategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    subcategoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    subcategoryEntity.message = message;
  }
  final List<SubcategoryData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SubcategoryData>(e) as SubcategoryData)
      .toList();
  if (data != null) {
    subcategoryEntity.data = data;
  }
  return subcategoryEntity;
}

Map<String, dynamic> $SubcategoryEntityToJson(SubcategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension SubcategoryEntityExtension on SubcategoryEntity {
  SubcategoryEntity copyWith({
    int? status,
    String? message,
    List<SubcategoryData>? data,
  }) {
    return SubcategoryEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

SubcategoryData $SubcategoryDataFromJson(Map<String, dynamic> json) {
  final SubcategoryData subcategoryData = SubcategoryData();
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    subcategoryData.subCategoryId = subCategoryId;
  }
  final String? subCategoryName = jsonConvert.convert<String>(
      json['sub_category_name']);
  if (subCategoryName != null) {
    subcategoryData.subCategoryName = subCategoryName;
  }
  return subcategoryData;
}

Map<String, dynamic> $SubcategoryDataToJson(SubcategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['sub_category_id'] = entity.subCategoryId;
  data['sub_category_name'] = entity.subCategoryName;
  return data;
}

extension SubcategoryDataExtension on SubcategoryData {
  SubcategoryData copyWith({
    String? subCategoryId,
    String? subCategoryName,
  }) {
    return SubcategoryData()
      ..subCategoryId = subCategoryId ?? this.subCategoryId
      ..subCategoryName = subCategoryName ?? this.subCategoryName;
  }
}