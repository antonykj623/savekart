import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/ssm/s_s_m_ticket_entity.dart';

SSMTicketEntity $SSMTicketEntityFromJson(Map<String, dynamic> json) {
  final SSMTicketEntity sSMTicketEntity = SSMTicketEntity();
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    sSMTicketEntity.message = message;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    sSMTicketEntity.status = status;
  }
  final List<SSMTicketData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<SSMTicketData>(e) as SSMTicketData)
      .toList();
  if (data != null) {
    sSMTicketEntity.data = data;
  }
  return sSMTicketEntity;
}

Map<String, dynamic> $SSMTicketEntityToJson(SSMTicketEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['message'] = entity.message;
  data['status'] = entity.status;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension SSMTicketEntityExtension on SSMTicketEntity {
  SSMTicketEntity copyWith({
    String? message,
    String? status,
    List<SSMTicketData>? data,
  }) {
    return SSMTicketEntity()
      ..message = message ?? this.message
      ..status = status ?? this.status
      ..data = data ?? this.data;
  }
}

SSMTicketData $SSMTicketDataFromJson(Map<String, dynamic> json) {
  final SSMTicketData sSMTicketData = SSMTicketData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    sSMTicketData.id = id;
  }
  final String? eventId = jsonConvert.convert<String>(json['event_id']);
  if (eventId != null) {
    sSMTicketData.eventId = eventId;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    sSMTicketData.name = name;
  }
  final String? mobile = jsonConvert.convert<String>(json['mobile']);
  if (mobile != null) {
    sSMTicketData.mobile = mobile;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    sSMTicketData.email = email;
  }
  final String? paymentType = jsonConvert.convert<String>(json['payment_type']);
  if (paymentType != null) {
    sSMTicketData.paymentType = paymentType;
  }
  final String? paymentDate = jsonConvert.convert<String>(json['payment_date']);
  if (paymentDate != null) {
    sSMTicketData.paymentDate = paymentDate;
  }
  final String? qty = jsonConvert.convert<String>(json['qty']);
  if (qty != null) {
    sSMTicketData.qty = qty;
  }
  final String? paymentStatus = jsonConvert.convert<String>(
      json['payment_status']);
  if (paymentStatus != null) {
    sSMTicketData.paymentStatus = paymentStatus;
  }
  return sSMTicketData;
}

Map<String, dynamic> $SSMTicketDataToJson(SSMTicketData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['event_id'] = entity.eventId;
  data['name'] = entity.name;
  data['mobile'] = entity.mobile;
  data['email'] = entity.email;
  data['payment_type'] = entity.paymentType;
  data['payment_date'] = entity.paymentDate;
  data['qty'] = entity.qty;
  data['payment_status'] = entity.paymentStatus;
  return data;
}

extension SSMTicketDataExtension on SSMTicketData {
  SSMTicketData copyWith({
    String? id,
    String? eventId,
    String? name,
    String? mobile,
    String? email,
    String? paymentType,
    String? paymentDate,
    String? qty,
    String? paymentStatus,
  }) {
    return SSMTicketData()
      ..id = id ?? this.id
      ..eventId = eventId ?? this.eventId
      ..name = name ?? this.name
      ..mobile = mobile ?? this.mobile
      ..email = email ?? this.email
      ..paymentType = paymentType ?? this.paymentType
      ..paymentDate = paymentDate ?? this.paymentDate
      ..qty = qty ?? this.qty
      ..paymentStatus = paymentStatus ?? this.paymentStatus;
  }
}