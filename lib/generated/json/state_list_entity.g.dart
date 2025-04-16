import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/state_list_entity.dart';

StateListEntity $StateListEntityFromJson(Map<String, dynamic> json) {
  final StateListEntity stateListEntity = StateListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    stateListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    stateListEntity.message = message;
  }
  final List<StateListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<StateListData>(e) as StateListData)
      .toList();
  if (data != null) {
    stateListEntity.data = data;
  }
  return stateListEntity;
}

Map<String, dynamic> $StateListEntityToJson(StateListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension StateListEntityExtension on StateListEntity {
  StateListEntity copyWith({
    int? status,
    String? message,
    List<StateListData>? data,
  }) {
    return StateListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

StateListData $StateListDataFromJson(Map<String, dynamic> json) {
  final StateListData stateListData = StateListData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    stateListData.id = id;
  }
  final String? code = jsonConvert.convert<String>(json['code']);
  if (code != null) {
    stateListData.code = code;
  }
  final String? stateName = jsonConvert.convert<String>(json['state_name']);
  if (stateName != null) {
    stateListData.stateName = stateName;
  }
  final String? stateCode = jsonConvert.convert<String>(json['state_code']);
  if (stateCode != null) {
    stateListData.stateCode = stateCode;
  }
  return stateListData;
}

Map<String, dynamic> $StateListDataToJson(StateListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['code'] = entity.code;
  data['state_name'] = entity.stateName;
  data['state_code'] = entity.stateCode;
  return data;
}

extension StateListDataExtension on StateListData {
  StateListData copyWith({
    String? id,
    String? code,
    String? stateName,
    String? stateCode,
  }) {
    return StateListData()
      ..id = id ?? this.id
      ..code = code ?? this.code
      ..stateName = stateName ?? this.stateName
      ..stateCode = stateCode ?? this.stateCode;
  }
}