import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/country_list_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/country_list_entity.g.dart';

@JsonSerializable()
class CountryListEntity {
	int? status = 0;
	String? message = '';
	List<CountryListData>? data = [];

	CountryListEntity();

	factory CountryListEntity.fromJson(Map<String, dynamic> json) => $CountryListEntityFromJson(json);

	Map<String, dynamic> toJson() => $CountryListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CountryListData {
	String? id = '';
	@JSONField(name: "country_name")
	String? countryName = '';
	@JSONField(name: "country_abr")
	String? countryAbr = '';
	@JSONField(name: "country_code")
	String? countryCode = '';
	String? currencyid = '';
	@JSONField(name: "currency_code")
	String? currencyCode = '';

	CountryListData();

	factory CountryListData.fromJson(Map<String, dynamic> json) => $CountryListDataFromJson(json);

	Map<String, dynamic> toJson() => $CountryListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}