import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/pg_response_entity.dart';

PgResponseEntity $PgResponseEntityFromJson(Map<String, dynamic> json) {
  final PgResponseEntity pgResponseEntity = PgResponseEntity();
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    pgResponseEntity.msg = msg;
  }
  final String? merchantCode = jsonConvert.convert<String>(
      json['merchant_code']);
  if (merchantCode != null) {
    pgResponseEntity.merchantCode = merchantCode;
  }
  return pgResponseEntity;
}

Map<String, dynamic> $PgResponseEntityToJson(PgResponseEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msg'] = entity.msg;
  data['merchant_code'] = entity.merchantCode;
  return data;
}

extension PgResponseEntityExtension on PgResponseEntity {
  PgResponseEntity copyWith({
    String? msg,
    String? merchantCode,
  }) {
    return PgResponseEntity()
      ..msg = msg ?? this.msg
      ..merchantCode = merchantCode ?? this.merchantCode;
  }
}