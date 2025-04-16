import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/sub_category_entity.dart';

SubCategoryEntity $SubCategoryEntityFromJson(Map<String, dynamic> json) {
  final SubCategoryEntity subCategoryEntity = SubCategoryEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    subCategoryEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    subCategoryEntity.message = message;
  }
  final List<SubCategoryData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SubCategoryData>(e) as SubCategoryData)
      .toList();
  if (data != null) {
    subCategoryEntity.data = data;
  }
  return subCategoryEntity;
}

Map<String, dynamic> $SubCategoryEntityToJson(SubCategoryEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension SubCategoryEntityExtension on SubCategoryEntity {
  SubCategoryEntity copyWith({
    int? status,
    String? message,
    List<SubCategoryData>? data,
  }) {
    return SubCategoryEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

SubCategoryData $SubCategoryDataFromJson(Map<String, dynamic> json) {
  final SubCategoryData subCategoryData = SubCategoryData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    subCategoryData.id = id;
  }
  final String? subCategoryName = jsonConvert.convert<String>(
      json['sub_category_name']);
  if (subCategoryName != null) {
    subCategoryData.subCategoryName = subCategoryName;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    subCategoryData.categoryId = categoryId;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    subCategoryData.status = status;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    subCategoryData.image = image;
  }
  return subCategoryData;
}

Map<String, dynamic> $SubCategoryDataToJson(SubCategoryData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['sub_category_name'] = entity.subCategoryName;
  data['category_id'] = entity.categoryId;
  data['status'] = entity.status;
  data['image'] = entity.image;
  return data;
}

extension SubCategoryDataExtension on SubCategoryData {
  SubCategoryData copyWith({
    String? id,
    String? subCategoryName,
    String? categoryId,
    String? status,
    String? image,
  }) {
    return SubCategoryData()
      ..id = id ?? this.id
      ..subCategoryName = subCategoryName ?? this.subCategoryName
      ..categoryId = categoryId ?? this.categoryId
      ..status = status ?? this.status
      ..image = image ?? this.image;
  }
}