import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/soldcount_entity.dart';

SoldcountEntity $SoldcountEntityFromJson(Map<String, dynamic> json) {
  final SoldcountEntity soldcountEntity = SoldcountEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    soldcountEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    soldcountEntity.message = message;
  }
  final int? availableCount = jsonConvert.convert<int>(json['available_count']);
  if (availableCount != null) {
    soldcountEntity.availableCount = availableCount;
  }
  return soldcountEntity;
}

Map<String, dynamic> $SoldcountEntityToJson(SoldcountEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['available_count'] = entity.availableCount;
  return data;
}

extension SoldcountEntityExtension on SoldcountEntity {
  SoldcountEntity copyWith({
    int? status,
    String? message,
    int? availableCount,
  }) {
    return SoldcountEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..availableCount = availableCount ?? this.availableCount;
  }
}