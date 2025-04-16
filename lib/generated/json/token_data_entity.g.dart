import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/token_data_entity.dart';

TokenDataEntity $TokenDataEntityFromJson(Map<String, dynamic> json) {
  final TokenDataEntity tokenDataEntity = TokenDataEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    tokenDataEntity.status = status;
  }
  final String? token = jsonConvert.convert<String>(json['token']);
  if (token != null) {
    tokenDataEntity.token = token;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    tokenDataEntity.message = message;
  }
  return tokenDataEntity;
}

Map<String, dynamic> $TokenDataEntityToJson(TokenDataEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['token'] = entity.token;
  data['message'] = entity.message;
  return data;
}

extension TokenDataEntityExtension on TokenDataEntity {
  TokenDataEntity copyWith({
    int? status,
    String? token,
    String? message,
  }) {
    return TokenDataEntity()
      ..status = status ?? this.status
      ..token = token ?? this.token
      ..message = message ?? this.message;
  }
}