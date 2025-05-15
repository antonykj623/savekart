import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/points_entity.dart';

PointsEntity $PointsEntityFromJson(Map<String, dynamic> json) {
  final PointsEntity pointsEntity = PointsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    pointsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    pointsEntity.message = message;
  }
  final List<PointsData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<PointsData>(e) as PointsData).toList();
  if (data != null) {
    pointsEntity.data = data;
  }
  return pointsEntity;
}

Map<String, dynamic> $PointsEntityToJson(PointsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension PointsEntityExtension on PointsEntity {
  PointsEntity copyWith({
    int? status,
    String? message,
    List<PointsData>? data,
  }) {
    return PointsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

PointsData $PointsDataFromJson(Map<String, dynamic> json) {
  final PointsData pointsData = PointsData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    pointsData.id = id;
  }
  final String? regId = jsonConvert.convert<String>(json['reg_id']);
  if (regId != null) {
    pointsData.regId = regId;
  }
  final String? credit = jsonConvert.convert<String>(json['credit']);
  if (credit != null) {
    pointsData.credit = credit;
  }
  final String? debit = jsonConvert.convert<String>(json['debit']);
  if (debit != null) {
    pointsData.debit = debit;
  }
  final String? balance = jsonConvert.convert<String>(json['balance']);
  if (balance != null) {
    pointsData.balance = balance;
  }
  final String? insDate = jsonConvert.convert<String>(json['ins_date']);
  if (insDate != null) {
    pointsData.insDate = insDate;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (insDate != null) {
    pointsData.description = description;
  }

  return pointsData;
}

Map<String, dynamic> $PointsDataToJson(PointsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['reg_id'] = entity.regId;
  data['credit'] = entity.credit;
  data['debit'] = entity.debit;
  data['balance'] = entity.balance;
  data['ins_date'] = entity.insDate;
  data['description']=entity.description;
  return data;
}

extension PointsDataExtension on PointsData {
  PointsData copyWith({
    String? id,
    String? regId,
    String? credit,
    String? debit,
    String? balance,
    String? insDate,
    String? description
  }) {
    return PointsData()
      ..id = id ?? this.id
      ..regId = regId ?? this.regId
      ..credit = credit ?? this.credit
      ..debit = debit ?? this.debit
      ..balance = balance ?? this.balance
      ..insDate = insDate ?? this.insDate
      ..description=description ?? this.description

    ;
  }
}