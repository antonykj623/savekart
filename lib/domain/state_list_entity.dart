import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/state_list_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/state_list_entity.g.dart';

@JsonSerializable()
class StateListEntity {
	int? status = 0;
	String? message = '';
	List<StateListData>? data = [];

	StateListEntity();

	factory StateListEntity.fromJson(Map<String, dynamic> json) => $StateListEntityFromJson(json);

	Map<String, dynamic> toJson() => $StateListEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class StateListData {
	String? id = '';
	String? code = '';
	@JSONField(name: "state_name")
	String? stateName = '';
	@JSONField(name: "state_code")
	String? stateCode = '';

	StateListData();

	factory StateListData.fromJson(Map<String, dynamic> json) => $StateListDataFromJson(json);

	Map<String, dynamic> toJson() => $StateListDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}