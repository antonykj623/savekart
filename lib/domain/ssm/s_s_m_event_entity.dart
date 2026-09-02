import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/s_s_m_event_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/s_s_m_event_entity.g.dart';

@JsonSerializable()
class SSMEventEntity {
	String? message = '';
	String? status = '';
	SSMEventData? data;

	SSMEventEntity();

	factory SSMEventEntity.fromJson(Map<String, dynamic> json) => $SSMEventEntityFromJson(json);

	Map<String, dynamic> toJson() => $SSMEventEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SSMEventData {
	String? id = '';
	@JSONField(name: "event_name")
	String? eventName = '';
	@JSONField(name: "event_date")
	String? eventDate = '';
	String? time = '';
	String? venue = '';
	String? place = '';
	String? description = '';
	@JSONField(name: "ticket_amount")
	String? ticketAmount = '0.00';
	@JSONField(name: "seat_count")
	String? seatCount = '';
	String? visibility = '';
	@JSONField(name: "created_at")
	String? createdAt = '';

	SSMEventData();

	factory SSMEventData.fromJson(Map<String, dynamic> json) => $SSMEventDataFromJson(json);

	Map<String, dynamic> toJson() => $SSMEventDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}