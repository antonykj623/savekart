import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/brand_entity.dart';

BrandEntity $BrandEntityFromJson(Map<String, dynamic> json) {
  final BrandEntity brandEntity = BrandEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    brandEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    brandEntity.message = message;
  }
  final List<BrandData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<BrandData>(e) as BrandData).toList();
  if (data != null) {
    brandEntity.data = data;
  }
  return brandEntity;
}

Map<String, dynamic> $BrandEntityToJson(BrandEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension BrandEntityExtension on BrandEntity {
  BrandEntity copyWith({
    int? status,
    String? message,
    List<BrandData>? data,
  }) {
    return BrandEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

BrandData $BrandDataFromJson(Map<String, dynamic> json) {
  final BrandData brandData = BrandData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    brandData.id = id;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    brandData.name = name;
  }
  final String? image = jsonConvert.convert<String>(json['image']);
  if (image != null) {
    brandData.image = image;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    brandData.status = status;
  }
  return brandData;
}

Map<String, dynamic> $BrandDataToJson(BrandData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['name'] = entity.name;
  data['image'] = entity.image;
  data['status'] = entity.status;
  return data;
}

extension BrandDataExtension on BrandData {
  BrandData copyWith({
    String? id,
    String? name,
    String? image,
    String? status,
  }) {
    return BrandData()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..image = image ?? this.image
      ..status = status ?? this.status;
  }
}