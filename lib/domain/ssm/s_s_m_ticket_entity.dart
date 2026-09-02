import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/s_s_m_ticket_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/s_s_m_ticket_entity.g.dart';

@JsonSerializable()
class SSMTicketEntity {
	String? message = '';
	String? status = '';
	List<SSMTicketData>? data = [];

	SSMTicketEntity();

	factory SSMTicketEntity.fromJson(Map<String, dynamic> json) => $SSMTicketEntityFromJson(json);

	Map<String, dynamic> toJson() => $SSMTicketEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SSMTicketData {
	String? id = '';
	@JSONField(name: "event_id")
	String? eventId = '';
	String? name = '';
	String? mobile = '';
	String? email = '';
	@JSONField(name: "payment_type")
	String? paymentType = '';
	@JSONField(name: "payment_date")
	String? paymentDate = '';
	String? qty = '';
	@JSONField(name: "payment_status")
	String? paymentStatus = '';

	SSMTicketData();

	factory SSMTicketData.fromJson(Map<String, dynamic> json) => $SSMTicketDataFromJson(json);

	Map<String, dynamic> toJson() => $SSMTicketDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}