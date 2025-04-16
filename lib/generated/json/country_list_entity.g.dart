import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/country_list_entity.dart';

CountryListEntity $CountryListEntityFromJson(Map<String, dynamic> json) {
  final CountryListEntity countryListEntity = CountryListEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    countryListEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    countryListEntity.message = message;
  }
  final List<CountryListData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<CountryListData>(e) as CountryListData)
      .toList();
  if (data != null) {
    countryListEntity.data = data;
  }
  return countryListEntity;
}

Map<String, dynamic> $CountryListEntityToJson(CountryListEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension CountryListEntityExtension on CountryListEntity {
  CountryListEntity copyWith({
    int? status,
    String? message,
    List<CountryListData>? data,
  }) {
    return CountryListEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

CountryListData $CountryListDataFromJson(Map<String, dynamic> json) {
  final CountryListData countryListData = CountryListData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    countryListData.id = id;
  }
  final String? countryName = jsonConvert.convert<String>(json['country_name']);
  if (countryName != null) {
    countryListData.countryName = countryName;
  }
  final String? countryAbr = jsonConvert.convert<String>(json['country_abr']);
  if (countryAbr != null) {
    countryListData.countryAbr = countryAbr;
  }
  final String? countryCode = jsonConvert.convert<String>(json['country_code']);
  if (countryCode != null) {
    countryListData.countryCode = countryCode;
  }
  final String? currencyid = jsonConvert.convert<String>(json['currencyid']);
  if (currencyid != null) {
    countryListData.currencyid = currencyid;
  }
  final String? currencyCode = jsonConvert.convert<String>(
      json['currency_code']);
  if (currencyCode != null) {
    countryListData.currencyCode = currencyCode;
  }
  return countryListData;
}

Map<String, dynamic> $CountryListDataToJson(CountryListData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['country_name'] = entity.countryName;
  data['country_abr'] = entity.countryAbr;
  data['country_code'] = entity.countryCode;
  data['currencyid'] = entity.currencyid;
  data['currency_code'] = entity.currencyCode;
  return data;
}

extension CountryListDataExtension on CountryListData {
  CountryListData copyWith({
    String? id,
    String? countryName,
    String? countryAbr,
    String? countryCode,
    String? currencyid,
    String? currencyCode,
  }) {
    return CountryListData()
      ..id = id ?? this.id
      ..countryName = countryName ?? this.countryName
      ..countryAbr = countryAbr ?? this.countryAbr
      ..countryCode = countryCode ?? this.countryCode
      ..currencyid = currencyid ?? this.currencyid
      ..currencyCode = currencyCode ?? this.currencyCode;
  }
}