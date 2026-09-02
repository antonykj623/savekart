import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/ssm/s_s_m_event_entity.dart';

SSMEventEntity $SSMEventEntityFromJson(Map<String, dynamic> json) {
  final SSMEventEntity sSMEventEntity = SSMEventEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    sSMEventEntity.message = message;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    sSMEventEntity.status = status;
  }
  final SSMEventData? data = jsonConvert.convert<SSMEventData>(json['data']);
  if (data != null) {
    sSMEventEntity.data = data;
  }
  return sSMEventEntity;
}

Map<String, dynamic> $SSMEventEntityToJson(SSMEventEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['data'] = entity.data?.toJson();
  return data;
}

extension SSMEventEntityExtension on SSMEventEntity {
  SSMEventEntity copyWith({
    String? message,
    String? status,
    SSMEventData? data,
  }) {
    return SSMEventEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

SSMEventData $SSMEventDataFromJson(Map<String, dynamic> json) {
  final SSMEventData sSMEventData = SSMEventData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    sSMEventData.id = id;
  }
  final String? eventName = jsonConvert.convert<String>(json['event_name']);
  if (eventName != null) {
    sSMEventData.eventName = eventName;
  }
  final String? eventDate = jsonConvert.convert<String>(json['event_date']);
  if (eventDate != null) {
    sSMEventData.eventDate = eventDate;
  }
  final String? time = jsonConvert.convert<String>(json['time']);
  if (time != null) {
    sSMEventData.time = time;
  }
  final String? venue = jsonConvert.convert<String>(json['venue']);
  if (venue != null) {
    sSMEventData.venue = venue;
  }
  final String? place = jsonConvert.convert<String>(json['place']);
  if (place != null) {
    sSMEventData.place = place;
  }
  final String? description = jsonConvert.convert<String>(json['description']);
  if (description != null) {
    sSMEventData.description = description;
  }
  final String? ticketAmount = jsonConvert.convert<String>(
      json['ticket_amount']);
  if (ticketAmount != null) {
    sSMEventData.ticketAmount = ticketAmount;
  }
  final String? seatCount = jsonConvert.convert<String>(json['seat_count']);
  if (seatCount != null) {
    sSMEventData.seatCount = seatCount;
  }
  final String? visibility = jsonConvert.convert<String>(json['visibility']);
  if (visibility != null) {
    sSMEventData.visibility = visibility;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    sSMEventData.createdAt = createdAt;
  }
  return sSMEventData;
}

Map<String, dynamic> $SSMEventDataToJson(SSMEventData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['event_name'] = entity.eventName;
  data['event_date'] = entity.eventDate;
  data['time'] = entity.time;
  data['venue'] = entity.venue;
  data['place'] = entity.place;
  data['description'] = entity.description;
  data['ticket_amount'] = entity.ticketAmount;
  data['seat_count'] = entity.seatCount;
  data['visibility'] = entity.visibility;
  data['created_at'] = entity.createdAt;
  return data;
}

extension SSMEventDataExtension on SSMEventData {
  SSMEventData copyWith({
    String? id,
    String? eventName,
    String? eventDate,
    String? time,
    String? venue,
    String? place,
    String? description,
    String? ticketAmount,
    String? seatCount,
    String? visibility,
    String? createdAt,
  }) {
    return SSMEventData()
      ..id = id ?? this.id
      ..eventName = eventName ?? this.eventName
      ..eventDate = eventDate ?? this.eventDate
      ..time = time ?? this.time
      ..venue = venue ?? this.venue
      ..place = place ?? this.place
      ..description = description ?? this.description
      ..ticketAmount = ticketAmount ?? this.ticketAmount
      ..seatCount = seatCount ?? this.seatCount
      ..visibility = visibility ?? this.visibility
      ..createdAt = createdAt ?? this.createdAt;
  }
}