import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/points_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/points_entity.g.dart';

@JsonSerializable()
class PointsEntity {
	int? status = 0;
	String? message = '';
	List<PointsData>? data = [];

	PointsEntity();

	factory PointsEntity.fromJson(Map<String, dynamic> json) => $PointsEntityFromJson(json);

	Map<String, dynamic> toJson() => $PointsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class PointsData {
	String? id = '';
	@JSONField(name: "reg_id")
	String? regId = '';
	String? credit = '';
	String? debit = '';
	String? balance = '';
	@JSONField(name: "ins_date")
	String? insDate = '';
	String? description='';


	PointsData();

	factory PointsData.fromJson(Map<String, dynamic> json) => $PointsDataFromJson(json);

	Map<String, dynamic> toJson() => $PointsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}