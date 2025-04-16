import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/order_details_entity.dart';

OrderDetailsEntity $OrderDetailsEntityFromJson(Map<String, dynamic> json) {
  final OrderDetailsEntity orderDetailsEntity = OrderDetailsEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    orderDetailsEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    orderDetailsEntity.message = message;
  }
  final String? serverDate = jsonConvert.convert<String>(json['server_date']);
  if (serverDate != null) {
    orderDetailsEntity.serverDate = serverDate;
  }
  final List<OrderDetailsData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<OrderDetailsData>(e) as OrderDetailsData)
      .toList();
  if (data != null) {
    orderDetailsEntity.data = data;
  }
  return orderDetailsEntity;
}

Map<String, dynamic> $OrderDetailsEntityToJson(OrderDetailsEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['server_date'] = entity.serverDate;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension OrderDetailsEntityExtension on OrderDetailsEntity {
  OrderDetailsEntity copyWith({
    int? status,
    String? message,
    String? serverDate,
    List<OrderDetailsData>? data,
  }) {
    return OrderDetailsEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..serverDate = serverDate ?? this.serverDate
      ..data = data ?? this.data;
  }
}

OrderDetailsData $OrderDetailsDataFromJson(Map<String, dynamic> json) {
  final OrderDetailsData orderDetailsData = OrderDetailsData();
  final OrderDetailsDataCartOrder? cartOrder = jsonConvert.convert<
      OrderDetailsDataCartOrder>(json['cart_order']);
  if (cartOrder != null) {
    orderDetailsData.cartOrder = cartOrder;
  }
  final OrderDetailsDataCartStock? cartStock = jsonConvert.convert<
      OrderDetailsDataCartStock>(json['cart_stock']);
  if (cartStock != null) {
    orderDetailsData.cartStock = cartStock;
  }
  final OrderDetailsDataCartProduct? cartProduct = jsonConvert.convert<
      OrderDetailsDataCartProduct>(json['cart_product']);
  if (cartProduct != null) {
    orderDetailsData.cartProduct = cartProduct;
  }
  final OrderDetailsDataCartReturnRequests? cartReturnRequests = jsonConvert
      .convert<OrderDetailsDataCartReturnRequests>(
      json['cart_return_requests']);
  if (cartReturnRequests != null) {
    orderDetailsData.cartReturnRequests = cartReturnRequests;
  }
  return orderDetailsData;
}

Map<String, dynamic> $OrderDetailsDataToJson(OrderDetailsData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cart_order'] = entity.cartOrder?.toJson();
  data['cart_stock'] = entity.cartStock?.toJson();
  data['cart_product'] = entity.cartProduct?.toJson();
  data['cart_return_requests'] = entity.cartReturnRequests?.toJson();
  return data;
}

extension OrderDetailsDataExtension on OrderDetailsData {
  OrderDetailsData copyWith({
    OrderDetailsDataCartOrder? cartOrder,
    OrderDetailsDataCartStock? cartStock,
    OrderDetailsDataCartProduct? cartProduct,
    OrderDetailsDataCartReturnRequests? cartReturnRequests,
  }) {
    return OrderDetailsData()
      ..cartOrder = cartOrder ?? this.cartOrder
      ..cartStock = cartStock ?? this.cartStock
      ..cartProduct = cartProduct ?? this.cartProduct
      ..cartReturnRequests = cartReturnRequests ?? this.cartReturnRequests;
  }
}

OrderDetailsDataCartOrder $OrderDetailsDataCartOrderFromJson(
    Map<String, dynamic> json) {
  final OrderDetailsDataCartOrder orderDetailsDataCartOrder = OrderDetailsDataCartOrder();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderDetailsDataCartOrder.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    orderDetailsDataCartOrder.productId = productId;
  }
  final String? quantity = jsonConvert.convert<String>(json['quantity']);
  if (quantity != null) {
    orderDetailsDataCartOrder.quantity = quantity;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    orderDetailsDataCartOrder.price = price;
  }
  final String? stockid = jsonConvert.convert<String>(json['stockid']);
  if (stockid != null) {
    orderDetailsDataCartOrder.stockid = stockid;
  }
  final String? netpayablecommission = jsonConvert.convert<String>(
      json['netpayablecommission']);
  if (netpayablecommission != null) {
    orderDetailsDataCartOrder.netpayablecommission = netpayablecommission;
  }
  final String? sponsorCasback = jsonConvert.convert<String>(
      json['sponsor_casback']);
  if (sponsorCasback != null) {
    orderDetailsDataCartOrder.sponsorCasback = sponsorCasback;
  }
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    orderDetailsDataCartOrder.orderId = orderId;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    orderDetailsDataCartOrder.status = status;
  }
  final dynamic statusUpdDate = json['status_upd_date'];
  if (statusUpdDate != null) {
    orderDetailsDataCartOrder.statusUpdDate = statusUpdDate;
  }
  final String? orderItemStatus = jsonConvert.convert<String>(
      json['order_item_status']);
  if (orderItemStatus != null) {
    orderDetailsDataCartOrder.orderItemStatus = orderItemStatus;
  }
  final String? initiateConfirm = jsonConvert.convert<String>(
      json['initiate_confirm']);
  if (initiateConfirm != null) {
    orderDetailsDataCartOrder.initiateConfirm = initiateConfirm;
  }
  final String? orderItemUpdDate = jsonConvert.convert<String>(
      json['order_item_upd_date']);
  if (orderItemUpdDate != null) {
    orderDetailsDataCartOrder.orderItemUpdDate = orderItemUpdDate;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    orderDetailsDataCartOrder.userId = userId;
  }
  final dynamic updateBy = json['update_by'];
  if (updateBy != null) {
    orderDetailsDataCartOrder.updateBy = updateBy;
  }
  final String? vendorConfirmationUpdatedBy = jsonConvert.convert<String>(
      json['vendor_confirmation_updated_by']);
  if (vendorConfirmationUpdatedBy != null) {
    orderDetailsDataCartOrder.vendorConfirmationUpdatedBy =
        vendorConfirmationUpdatedBy;
  }
  final dynamic vendorConfirmationUpdatedAt = json['vendor_confirmation_updated_at'];
  if (vendorConfirmationUpdatedAt != null) {
    orderDetailsDataCartOrder.vendorConfirmationUpdatedAt =
        vendorConfirmationUpdatedAt;
  }
  final dynamic packingEmpoyeeId = json['packing_empoyee_id'];
  if (packingEmpoyeeId != null) {
    orderDetailsDataCartOrder.packingEmpoyeeId = packingEmpoyeeId;
  }
  final String? packedAt = jsonConvert.convert<String>(json['packed_at']);
  if (packedAt != null) {
    orderDetailsDataCartOrder.packedAt = packedAt;
  }
  final String? invoiceStatus = jsonConvert.convert<String>(
      json['invoice_status']);
  if (invoiceStatus != null) {
    orderDetailsDataCartOrder.invoiceStatus = invoiceStatus;
  }
  final dynamic shippedEmpId = json['shipped_emp_id'];
  if (shippedEmpId != null) {
    orderDetailsDataCartOrder.shippedEmpId = shippedEmpId;
  }
  final String? shippedAt = jsonConvert.convert<String>(json['shipped_at']);
  if (shippedAt != null) {
    orderDetailsDataCartOrder.shippedAt = shippedAt;
  }
  final dynamic deliveringAgencyId = json['delivering_agency_id'];
  if (deliveringAgencyId != null) {
    orderDetailsDataCartOrder.deliveringAgencyId = deliveringAgencyId;
  }
  final dynamic podNumber = json['pod_number'];
  if (podNumber != null) {
    orderDetailsDataCartOrder.podNumber = podNumber;
  }
  final String? deliveryStatusFromAgency = jsonConvert.convert<String>(
      json['delivery_status_from_agency']);
  if (deliveryStatusFromAgency != null) {
    orderDetailsDataCartOrder.deliveryStatusFromAgency =
        deliveryStatusFromAgency;
  }
  final String? deliveryRecvedDateFromAgency = jsonConvert.convert<String>(
      json['delivery_recved_date_from_agency']);
  if (deliveryRecvedDateFromAgency != null) {
    orderDetailsDataCartOrder.deliveryRecvedDateFromAgency =
        deliveryRecvedDateFromAgency;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    orderDetailsDataCartOrder.createdAt = createdAt;
  }
  final dynamic cancelledAt = json['cancelled_at'];
  if (cancelledAt != null) {
    orderDetailsDataCartOrder.cancelledAt = cancelledAt;
  }
  return orderDetailsDataCartOrder;
}

Map<String, dynamic> $OrderDetailsDataCartOrderToJson(
    OrderDetailsDataCartOrder entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['quantity'] = entity.quantity;
  data['price'] = entity.price;
  data['stockid'] = entity.stockid;
  data['netpayablecommission'] = entity.netpayablecommission;
  data['sponsor_casback'] = entity.sponsorCasback;
  data['order_id'] = entity.orderId;
  data['status'] = entity.status;
  data['status_upd_date'] = entity.statusUpdDate;
  data['order_item_status'] = entity.orderItemStatus;
  data['initiate_confirm'] = entity.initiateConfirm;
  data['order_item_upd_date'] = entity.orderItemUpdDate;
  data['user_id'] = entity.userId;
  data['update_by'] = entity.updateBy;
  data['vendor_confirmation_updated_by'] = entity.vendorConfirmationUpdatedBy;
  data['vendor_confirmation_updated_at'] = entity.vendorConfirmationUpdatedAt;
  data['packing_empoyee_id'] = entity.packingEmpoyeeId;
  data['packed_at'] = entity.packedAt;
  data['invoice_status'] = entity.invoiceStatus;
  data['shipped_emp_id'] = entity.shippedEmpId;
  data['shipped_at'] = entity.shippedAt;
  data['delivering_agency_id'] = entity.deliveringAgencyId;
  data['pod_number'] = entity.podNumber;
  data['delivery_status_from_agency'] = entity.deliveryStatusFromAgency;
  data['delivery_recved_date_from_agency'] =
      entity.deliveryRecvedDateFromAgency;
  data['created_at'] = entity.createdAt;
  data['cancelled_at'] = entity.cancelledAt;
  return data;
}

extension OrderDetailsDataCartOrderExtension on OrderDetailsDataCartOrder {
  OrderDetailsDataCartOrder copyWith({
    String? id,
    String? productId,
    String? quantity,
    String? price,
    String? stockid,
    String? netpayablecommission,
    String? sponsorCasback,
    String? orderId,
    String? status,
    dynamic statusUpdDate,
    String? orderItemStatus,
    String? initiateConfirm,
    String? orderItemUpdDate,
    String? userId,
    dynamic updateBy,
    String? vendorConfirmationUpdatedBy,
    dynamic vendorConfirmationUpdatedAt,
    dynamic packingEmpoyeeId,
    String? packedAt,
    String? invoiceStatus,
    dynamic shippedEmpId,
    String? shippedAt,
    dynamic deliveringAgencyId,
    dynamic podNumber,
    String? deliveryStatusFromAgency,
    String? deliveryRecvedDateFromAgency,
    String? createdAt,
    dynamic cancelledAt,
  }) {
    return OrderDetailsDataCartOrder()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..quantity = quantity ?? this.quantity
      ..price = price ?? this.price
      ..stockid = stockid ?? this.stockid
      ..netpayablecommission = netpayablecommission ?? this.netpayablecommission
      ..sponsorCasback = sponsorCasback ?? this.sponsorCasback
      ..orderId = orderId ?? this.orderId
      ..status = status ?? this.status
      ..statusUpdDate = statusUpdDate ?? this.statusUpdDate
      ..orderItemStatus = orderItemStatus ?? this.orderItemStatus
      ..initiateConfirm = initiateConfirm ?? this.initiateConfirm
      ..orderItemUpdDate = orderItemUpdDate ?? this.orderItemUpdDate
      ..userId = userId ?? this.userId
      ..updateBy = updateBy ?? this.updateBy
      ..vendorConfirmationUpdatedBy = vendorConfirmationUpdatedBy ??
          this.vendorConfirmationUpdatedBy
      ..vendorConfirmationUpdatedAt = vendorConfirmationUpdatedAt ??
          this.vendorConfirmationUpdatedAt
      ..packingEmpoyeeId = packingEmpoyeeId ?? this.packingEmpoyeeId
      ..packedAt = packedAt ?? this.packedAt
      ..invoiceStatus = invoiceStatus ?? this.invoiceStatus
      ..shippedEmpId = shippedEmpId ?? this.shippedEmpId
      ..shippedAt = shippedAt ?? this.shippedAt
      ..deliveringAgencyId = deliveringAgencyId ?? this.deliveringAgencyId
      ..podNumber = podNumber ?? this.podNumber
      ..deliveryStatusFromAgency = deliveryStatusFromAgency ??
          this.deliveryStatusFromAgency
      ..deliveryRecvedDateFromAgency = deliveryRecvedDateFromAgency ??
          this.deliveryRecvedDateFromAgency
      ..createdAt = createdAt ?? this.createdAt
      ..cancelledAt = cancelledAt ?? this.cancelledAt;
  }
}

OrderDetailsDataCartStock $OrderDetailsDataCartStockFromJson(
    Map<String, dynamic> json) {
  final OrderDetailsDataCartStock orderDetailsDataCartStock = OrderDetailsDataCartStock();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderDetailsDataCartStock.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    orderDetailsDataCartStock.productId = productId;
  }
  final dynamic dType = json['d_type'];
  if (dType != null) {
    orderDetailsDataCartStock.dType = dType;
  }
  final dynamic proidFrom = json['proid_from'];
  if (proidFrom != null) {
    orderDetailsDataCartStock.proidFrom = proidFrom;
  }
  final dynamic sz = json['sz'];
  if (sz != null) {
    orderDetailsDataCartStock.sz = sz;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    orderDetailsDataCartStock.vendorId = vendorId;
  }
  final String? currentQty = jsonConvert.convert<String>(json['current_qty']);
  if (currentQty != null) {
    orderDetailsDataCartStock.currentQty = currentQty;
  }
  final String? priceStock = jsonConvert.convert<String>(json['price_stock']);
  if (priceStock != null) {
    orderDetailsDataCartStock.priceStock = priceStock;
  }
  final String? mrp = jsonConvert.convert<String>(json['mrp']);
  if (mrp != null) {
    orderDetailsDataCartStock.mrp = mrp;
  }
  final String? savecartPrice = jsonConvert.convert<String>(
      json['savecart_price']);
  if (savecartPrice != null) {
    orderDetailsDataCartStock.savecartPrice = savecartPrice;
  }
  final String? ppRedemption = jsonConvert.convert<String>(
      json['pp_redemption']);
  if (ppRedemption != null) {
    orderDetailsDataCartStock.ppRedemption = ppRedemption;
  }
  final String? priceSales = jsonConvert.convert<String>(json['price_sales']);
  if (priceSales != null) {
    orderDetailsDataCartStock.priceSales = priceSales;
  }
  final String? igst = jsonConvert.convert<String>(json['igst']);
  if (igst != null) {
    orderDetailsDataCartStock.igst = igst;
  }
  final String? sgst = jsonConvert.convert<String>(json['sgst']);
  if (sgst != null) {
    orderDetailsDataCartStock.sgst = sgst;
  }
  final String? csgt = jsonConvert.convert<String>(json['csgt']);
  if (csgt != null) {
    orderDetailsDataCartStock.csgt = csgt;
  }
  final String? igstAmt = jsonConvert.convert<String>(json['igst_amt']);
  if (igstAmt != null) {
    orderDetailsDataCartStock.igstAmt = igstAmt;
  }
  final String? sgstAmt = jsonConvert.convert<String>(json['sgst_amt']);
  if (sgstAmt != null) {
    orderDetailsDataCartStock.sgstAmt = sgstAmt;
  }
  final String? cgstAmt = jsonConvert.convert<String>(json['cgst_amt']);
  if (cgstAmt != null) {
    orderDetailsDataCartStock.cgstAmt = cgstAmt;
  }
  final String? priceWithoutGst = jsonConvert.convert<String>(
      json['price_without_gst']);
  if (priceWithoutGst != null) {
    orderDetailsDataCartStock.priceWithoutGst = priceWithoutGst;
  }
  final String? margin = jsonConvert.convert<String>(json['margin']);
  if (margin != null) {
    orderDetailsDataCartStock.margin = margin;
  }
  final String? genShareAmt = jsonConvert.convert<String>(
      json['gen_share_amt']);
  if (genShareAmt != null) {
    orderDetailsDataCartStock.genShareAmt = genShareAmt;
  }
  final String? cashBack = jsonConvert.convert<String>(json['cash_back']);
  if (cashBack != null) {
    orderDetailsDataCartStock.cashBack = cashBack;
  }
  final String? stockEntryDate = jsonConvert.convert<String>(
      json['stock_entry_date']);
  if (stockEntryDate != null) {
    orderDetailsDataCartStock.stockEntryDate = stockEntryDate;
  }
  return orderDetailsDataCartStock;
}

Map<String, dynamic> $OrderDetailsDataCartStockToJson(
    OrderDetailsDataCartStock entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['d_type'] = entity.dType;
  data['proid_from'] = entity.proidFrom;
  data['sz'] = entity.sz;
  data['vendor_id'] = entity.vendorId;
  data['current_qty'] = entity.currentQty;
  data['price_stock'] = entity.priceStock;
  data['mrp'] = entity.mrp;
  data['savecart_price'] = entity.savecartPrice;
  data['pp_redemption'] = entity.ppRedemption;
  data['price_sales'] = entity.priceSales;
  data['igst'] = entity.igst;
  data['sgst'] = entity.sgst;
  data['csgt'] = entity.csgt;
  data['igst_amt'] = entity.igstAmt;
  data['sgst_amt'] = entity.sgstAmt;
  data['cgst_amt'] = entity.cgstAmt;
  data['price_without_gst'] = entity.priceWithoutGst;
  data['margin'] = entity.margin;
  data['gen_share_amt'] = entity.genShareAmt;
  data['cash_back'] = entity.cashBack;
  data['stock_entry_date'] = entity.stockEntryDate;
  return data;
}

extension OrderDetailsDataCartStockExtension on OrderDetailsDataCartStock {
  OrderDetailsDataCartStock copyWith({
    String? id,
    String? productId,
    dynamic dType,
    dynamic proidFrom,
    dynamic sz,
    String? vendorId,
    String? currentQty,
    String? priceStock,
    String? mrp,
    String? savecartPrice,
    String? ppRedemption,
    String? priceSales,
    String? igst,
    String? sgst,
    String? csgt,
    String? igstAmt,
    String? sgstAmt,
    String? cgstAmt,
    String? priceWithoutGst,
    String? margin,
    String? genShareAmt,
    String? cashBack,
    String? stockEntryDate,
  }) {
    return OrderDetailsDataCartStock()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..dType = dType ?? this.dType
      ..proidFrom = proidFrom ?? this.proidFrom
      ..sz = sz ?? this.sz
      ..vendorId = vendorId ?? this.vendorId
      ..currentQty = currentQty ?? this.currentQty
      ..priceStock = priceStock ?? this.priceStock
      ..mrp = mrp ?? this.mrp
      ..savecartPrice = savecartPrice ?? this.savecartPrice
      ..ppRedemption = ppRedemption ?? this.ppRedemption
      ..priceSales = priceSales ?? this.priceSales
      ..igst = igst ?? this.igst
      ..sgst = sgst ?? this.sgst
      ..csgt = csgt ?? this.csgt
      ..igstAmt = igstAmt ?? this.igstAmt
      ..sgstAmt = sgstAmt ?? this.sgstAmt
      ..cgstAmt = cgstAmt ?? this.cgstAmt
      ..priceWithoutGst = priceWithoutGst ?? this.priceWithoutGst
      ..margin = margin ?? this.margin
      ..genShareAmt = genShareAmt ?? this.genShareAmt
      ..cashBack = cashBack ?? this.cashBack
      ..stockEntryDate = stockEntryDate ?? this.stockEntryDate;
  }
}

OrderDetailsDataCartProduct $OrderDetailsDataCartProductFromJson(
    Map<String, dynamic> json) {
  final OrderDetailsDataCartProduct orderDetailsDataCartProduct = OrderDetailsDataCartProduct();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderDetailsDataCartProduct.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    orderDetailsDataCartProduct.productName = productName;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    orderDetailsDataCartProduct.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    orderDetailsDataCartProduct.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    orderDetailsDataCartProduct.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    orderDetailsDataCartProduct.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    orderDetailsDataCartProduct.primeImage = primeImage;
  }
  final String? sideImage1 = jsonConvert.convert<String>(json['side_image1']);
  if (sideImage1 != null) {
    orderDetailsDataCartProduct.sideImage1 = sideImage1;
  }
  final dynamic sideImage2 = json['side_image2'];
  if (sideImage2 != null) {
    orderDetailsDataCartProduct.sideImage2 = sideImage2;
  }
  final dynamic sideImage3 = json['side_image3'];
  if (sideImage3 != null) {
    orderDetailsDataCartProduct.sideImage3 = sideImage3;
  }
  final dynamic sideImage4 = json['side_image4'];
  if (sideImage4 != null) {
    orderDetailsDataCartProduct.sideImage4 = sideImage4;
  }
  final String? unitId = jsonConvert.convert<String>(json['unit_id']);
  if (unitId != null) {
    orderDetailsDataCartProduct.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    orderDetailsDataCartProduct.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    orderDetailsDataCartProduct.colorEnabled = colorEnabled;
  }
  final String? color = jsonConvert.convert<String>(json['color']);
  if (color != null) {
    orderDetailsDataCartProduct.color = color;
  }
  final String? size = jsonConvert.convert<String>(json['size']);
  if (size != null) {
    orderDetailsDataCartProduct.size = size;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    orderDetailsDataCartProduct.vendorId = vendorId;
  }
  final String? returnPolicyId = jsonConvert.convert<String>(
      json['return_policy_id']);
  if (returnPolicyId != null) {
    orderDetailsDataCartProduct.returnPolicyId = returnPolicyId;
  }
  final String? offeredItemStatus = jsonConvert.convert<String>(
      json['offered_item_status']);
  if (offeredItemStatus != null) {
    orderDetailsDataCartProduct.offeredItemStatus = offeredItemStatus;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    orderDetailsDataCartProduct.status = status;
  }
  final String? returnable = jsonConvert.convert<String>(json['returnable']);
  if (returnable != null) {
    orderDetailsDataCartProduct.returnable = returnable;
  }
  final String? returnDays = jsonConvert.convert<String>(json['return_days']);
  if (returnDays != null) {
    orderDetailsDataCartProduct.returnDays = returnDays;
  }
  return orderDetailsDataCartProduct;
}

Map<String, dynamic> $OrderDetailsDataCartProductToJson(
    OrderDetailsDataCartProduct entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_name'] = entity.productName;
  data['category_id'] = entity.categoryId;
  data['sub_category_id'] = entity.subCategoryId;
  data['product_description'] = entity.productDescription;
  data['product_spec'] = entity.productSpec;
  data['prime_image'] = entity.primeImage;
  data['side_image1'] = entity.sideImage1;
  data['side_image2'] = entity.sideImage2;
  data['side_image3'] = entity.sideImage3;
  data['side_image4'] = entity.sideImage4;
  data['unit_id'] = entity.unitId;
  data['size_enabled'] = entity.sizeEnabled;
  data['color_enabled'] = entity.colorEnabled;
  data['color'] = entity.color;
  data['size'] = entity.size;
  data['vendor_id'] = entity.vendorId;
  data['return_policy_id'] = entity.returnPolicyId;
  data['offered_item_status'] = entity.offeredItemStatus;
  data['status'] = entity.status;
  data['returnable'] = entity.returnable;
  data['return_days'] = entity.returnDays;
  return data;
}

extension OrderDetailsDataCartProductExtension on OrderDetailsDataCartProduct {
  OrderDetailsDataCartProduct copyWith({
    String? id,
    String? productName,
    String? categoryId,
    String? subCategoryId,
    String? productDescription,
    String? productSpec,
    String? primeImage,
    String? sideImage1,
    dynamic sideImage2,
    dynamic sideImage3,
    dynamic sideImage4,
    String? unitId,
    String? sizeEnabled,
    String? colorEnabled,
    String? color,
    String? size,
    String? vendorId,
    String? returnPolicyId,
    String? offeredItemStatus,
    String? status,
    String? returnable,
    String? returnDays,
  }) {
    return OrderDetailsDataCartProduct()
      ..id = id ?? this.id
      ..productName = productName ?? this.productName
      ..categoryId = categoryId ?? this.categoryId
      ..subCategoryId = subCategoryId ?? this.subCategoryId
      ..productDescription = productDescription ?? this.productDescription
      ..productSpec = productSpec ?? this.productSpec
      ..primeImage = primeImage ?? this.primeImage
      ..sideImage1 = sideImage1 ?? this.sideImage1
      ..sideImage2 = sideImage2 ?? this.sideImage2
      ..sideImage3 = sideImage3 ?? this.sideImage3
      ..sideImage4 = sideImage4 ?? this.sideImage4
      ..unitId = unitId ?? this.unitId
      ..sizeEnabled = sizeEnabled ?? this.sizeEnabled
      ..colorEnabled = colorEnabled ?? this.colorEnabled
      ..color = color ?? this.color
      ..size = size ?? this.size
      ..vendorId = vendorId ?? this.vendorId
      ..returnPolicyId = returnPolicyId ?? this.returnPolicyId
      ..offeredItemStatus = offeredItemStatus ?? this.offeredItemStatus
      ..status = status ?? this.status
      ..returnable = returnable ?? this.returnable
      ..returnDays = returnDays ?? this.returnDays;
  }
}

OrderDetailsDataCartReturnRequests $OrderDetailsDataCartReturnRequestsFromJson(
    Map<String, dynamic> json) {
  final OrderDetailsDataCartReturnRequests orderDetailsDataCartReturnRequests = OrderDetailsDataCartReturnRequests();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderDetailsDataCartReturnRequests.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    orderDetailsDataCartReturnRequests.productId = productId;
  }
  final String? productReturnPolicyId = jsonConvert.convert<String>(
      json['product_return_policy_id']);
  if (productReturnPolicyId != null) {
    orderDetailsDataCartReturnRequests.productReturnPolicyId =
        productReturnPolicyId;
  }
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    orderDetailsDataCartReturnRequests.orderId = orderId;
  }
  final String? image1 = jsonConvert.convert<String>(json['image1']);
  if (image1 != null) {
    orderDetailsDataCartReturnRequests.image1 = image1;
  }
  final String? image2 = jsonConvert.convert<String>(json['image2']);
  if (image2 != null) {
    orderDetailsDataCartReturnRequests.image2 = image2;
  }
  final String? image3 = jsonConvert.convert<String>(json['image3']);
  if (image3 != null) {
    orderDetailsDataCartReturnRequests.image3 = image3;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    orderDetailsDataCartReturnRequests.userId = userId;
  }
  final String? reason = jsonConvert.convert<String>(json['reason']);
  if (reason != null) {
    orderDetailsDataCartReturnRequests.reason = reason;
  }
  final String? createdAt = jsonConvert.convert<String>(json['created_at']);
  if (createdAt != null) {
    orderDetailsDataCartReturnRequests.createdAt = createdAt;
  }
  final dynamic refundedDate = json['refunded_date'];
  if (refundedDate != null) {
    orderDetailsDataCartReturnRequests.refundedDate = refundedDate;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    orderDetailsDataCartReturnRequests.status = status;
  }
  final String? refundStatus = jsonConvert.convert<String>(
      json['refund_status']);
  if (refundStatus != null) {
    orderDetailsDataCartReturnRequests.refundStatus = refundStatus;
  }
  return orderDetailsDataCartReturnRequests;
}

Map<String, dynamic> $OrderDetailsDataCartReturnRequestsToJson(
    OrderDetailsDataCartReturnRequests entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
  data['product_return_policy_id'] = entity.productReturnPolicyId;
  data['order_id'] = entity.orderId;
  data['image1'] = entity.image1;
  data['image2'] = entity.image2;
  data['image3'] = entity.image3;
  data['user_id'] = entity.userId;
  data['reason'] = entity.reason;
  data['created_at'] = entity.createdAt;
  data['refunded_date'] = entity.refundedDate;
  data['status'] = entity.status;
  data['refund_status'] = entity.refundStatus;
  return data;
}

extension OrderDetailsDataCartReturnRequestsExtension on OrderDetailsDataCartReturnRequests {
  OrderDetailsDataCartReturnRequests copyWith({
    String? id,
    String? productId,
    String? productReturnPolicyId,
    String? orderId,
    String? image1,
    String? image2,
    String? image3,
    String? userId,
    String? reason,
    String? createdAt,
    dynamic refundedDate,
    String? status,
    String? refundStatus,
  }) {
    return OrderDetailsDataCartReturnRequests()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
      ..productReturnPolicyId = productReturnPolicyId ??
          this.productReturnPolicyId
      ..orderId = orderId ?? this.orderId
      ..image1 = image1 ?? this.image1
      ..image2 = image2 ?? this.image2
      ..image3 = image3 ?? this.image3
      ..userId = userId ?? this.userId
      ..reason = reason ?? this.reason
      ..createdAt = createdAt ?? this.createdAt
      ..refundedDate = refundedDate ?? this.refundedDate
      ..status = status ?? this.status
      ..refundStatus = refundStatus ?? this.refundStatus;
  }
}