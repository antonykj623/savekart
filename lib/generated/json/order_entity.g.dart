import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/order_entity.dart';

OrderEntity $OrderEntityFromJson(Map<String, dynamic> json) {
  final OrderEntity orderEntity = OrderEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    orderEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    orderEntity.message = message;
  }
  final List<OrderData>? data = (json['data'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<OrderData>(e) as OrderData).toList();
  if (data != null) {
    orderEntity.data = data;
  }
  return orderEntity;
}

Map<String, dynamic> $OrderEntityToJson(OrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension OrderEntityExtension on OrderEntity {
  OrderEntity copyWith({
    int? status,
    String? message,
    List<OrderData>? data,
  }) {
    return OrderEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

OrderData $OrderDataFromJson(Map<String, dynamic> json) {
  final OrderData orderData = OrderData();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderData.id = id;
  }
  final String? regId = jsonConvert.convert<String>(json['reg_id']);
  if (regId != null) {
    orderData.regId = regId;
  }
  final String? dateOrder = jsonConvert.convert<String>(json['date_order']);
  if (dateOrder != null) {
    orderData.dateOrder = dateOrder;
  }
  final dynamic deliveryDate = json['delivery_date'];
  if (deliveryDate != null) {
    orderData.deliveryDate = deliveryDate;
  }
  final String? addressId = jsonConvert.convert<String>(json['address_id']);
  if (addressId != null) {
    orderData.addressId = addressId;
  }
  final String? totalprice = jsonConvert.convert<String>(json['totalprice']);
  if (totalprice != null) {
    orderData.totalprice = totalprice;
  }
  final dynamic paymentType = json['payment_type'];
  if (paymentType != null) {
    orderData.paymentType = paymentType;
  }
  final String? orderStatus = jsonConvert.convert<String>(json['order_status']);
  if (orderStatus != null) {
    orderData.orderStatus = orderStatus;
  }
  final String? billingStatus = jsonConvert.convert<String>(
      json['billing_status']);
  if (billingStatus != null) {
    orderData.billingStatus = billingStatus;
  }
  return orderData;
}

Map<String, dynamic> $OrderDataToJson(OrderData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['reg_id'] = entity.regId;
  data['date_order'] = entity.dateOrder;
  data['delivery_date'] = entity.deliveryDate;
  data['address_id'] = entity.addressId;
  data['totalprice'] = entity.totalprice;
  data['payment_type'] = entity.paymentType;
  data['order_status'] = entity.orderStatus;
  data['billing_status'] = entity.billingStatus;
  return data;
}

extension OrderDataExtension on OrderData {
  OrderData copyWith({
    String? id,
    String? regId,
    String? dateOrder,
    dynamic deliveryDate,
    String? addressId,
    String? totalprice,
    dynamic paymentType,
    String? orderStatus,
    String? billingStatus,
  }) {
    return OrderData()
      ..id = id ?? this.id
      ..regId = regId ?? this.regId
      ..dateOrder = dateOrder ?? this.dateOrder
      ..deliveryDate = deliveryDate ?? this.deliveryDate
      ..addressId = addressId ?? this.addressId
      ..totalprice = totalprice ?? this.totalprice
      ..paymentType = paymentType ?? this.paymentType
      ..orderStatus = orderStatus ?? this.orderStatus
      ..billingStatus = billingStatus ?? this.billingStatus;
  }
}