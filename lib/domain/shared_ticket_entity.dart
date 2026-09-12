import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/shared_ticket_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/shared_ticket_entity.g.dart';

@JsonSerializable()
class SharedTicketEntity {
	String? message = '';
	String? status = '';
	SharedTicketData? data;

	SharedTicketEntity();

	factory SharedTicketEntity.fromJson(Map<String, dynamic> json) => $SharedTicketEntityFromJson(json);

	Map<String, dynamic> toJson() => $SharedTicketEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SharedTicketData {
	String? id = '';
	@JSONField(name: "event_id")
	String? eventId = '';
	@JSONField(name: "event_ref_id")
	String? eventRefId = '';
	String? verified = '';
	@JSONField(name: "verified_date")
	String? verifiedDate = '';
	String? shared = '';
	@JSONField(name: "user_id")
	String? userId = '';

	SharedTicketData();

	factory SharedTicketData.fromJson(Map<String, dynamic> json) => $SharedTicketDataFromJson(json);

	Map<String, dynamic> toJson() => $SharedTicketDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}