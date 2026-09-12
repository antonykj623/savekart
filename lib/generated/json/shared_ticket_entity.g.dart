import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/shared_ticket_entity.dart';

SharedTicketEntity $SharedTicketEntityFromJson(Map<String, dynamic> json) {
  final SharedTicketEntity sharedTicketEntity = SharedTicketEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    sharedTicketEntity.message = message;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    sharedTicketEntity.status = status;
  }
  final SharedTicketData? data = jsonConvert.convert<SharedTicketData>(
      json['data']);
  if (data != null) {
    sharedTicketEntity.data = data;
  }
  return sharedTicketEntity;
}

Map<String, dynamic> $SharedTicketEntityToJson(SharedTicketEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension SharedTicketEntityExtension on SharedTicketEntity {
  SharedTicketEntity copyWith({
    String? message,
    String? status,
    SharedTicketData? data,
  }) {
    return SharedTicketEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

SharedTicketData $SharedTicketDataFromJson(Map<String, dynamic> json) {
  final SharedTicketData sharedTicketData = SharedTicketData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    sharedTicketData.id = id;
  }
  final String? eventId = jsonConvert.convert<String>(json['event_id']);
  if (eventId != null) {
    sharedTicketData.eventId = eventId;
  }
  final String? eventRefId = jsonConvert.convert<String>(json['event_ref_id']);
  if (eventRefId != null) {
    sharedTicketData.eventRefId = eventRefId;
  }
  final String? verified = jsonConvert.convert<String>(json['verified']);
  if (verified != null) {
    sharedTicketData.verified = verified;
  }
  final String? verifiedDate = jsonConvert.convert<String>(
      json['verified_date']);
  if (verifiedDate != null) {
    sharedTicketData.verifiedDate = verifiedDate;
  }
  final String? shared = jsonConvert.convert<String>(json['shared']);
  if (shared != null) {
    sharedTicketData.shared = shared;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    sharedTicketData.userId = userId;
  }
  return sharedTicketData;
}

Map<String, dynamic> $SharedTicketDataToJson(SharedTicketData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['event_id'] = entity.eventId;
  data['event_ref_id'] = entity.eventRefId;
  data['verified'] = entity.verified;
  data['verified_date'] = entity.verifiedDate;
  data['shared'] = entity.shared;
  data['user_id'] = entity.userId;
  return data;
}

extension SharedTicketDataExtension on SharedTicketData {
  SharedTicketData copyWith({
    String? id,
    String? eventId,
    String? eventRefId,
    String? verified,
    String? verifiedDate,
    String? shared,
    String? userId,
  }) {
    return SharedTicketData()
      ..id = id ?? this.id
      ..eventId = eventId ?? this.eventId
      ..eventRefId = eventRefId ?? this.eventRefId
      ..verified = verified ?? this.verified
      ..verifiedDate = verifiedDate ?? this.verifiedDate
      ..shared = shared ?? this.shared
      ..userId = userId ?? this.userId;
  }
}