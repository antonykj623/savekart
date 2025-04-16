import 'package:savekart/generated/json/base/json_convert_content.dart';
import 'package:savekart/domain/order_item_by_i_d_entity.dart';

OrderItemByIDEntity $OrderItemByIDEntityFromJson(Map<String, dynamic> json) {
  final OrderItemByIDEntity orderItemByIDEntity = OrderItemByIDEntity();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    orderItemByIDEntity.status = status;
  }
  final String? message = jsonConvert.convert<String>(json['message']);
  if (message != null) {
    orderItemByIDEntity.message = message;
  }
  final OrderItemByIDData? data = jsonConvert.convert<OrderItemByIDData>(
      json['data']);
  if (data != null) {
    orderItemByIDEntity.data = data;
  }
  return orderItemByIDEntity;
}

Map<String, dynamic> $OrderItemByIDEntityToJson(OrderItemByIDEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['message'] = entity.message;
  data['data'] = entity.data?.toJson();
  return data;
}

extension OrderItemByIDEntityExtension on OrderItemByIDEntity {
  OrderItemByIDEntity copyWith({
    int? status,
    String? message,
    OrderItemByIDData? data,
  }) {
    return OrderItemByIDEntity()
      ..status = status ?? this.status
      ..message = message ?? this.message
      ..data = data ?? this.data;
  }
}

OrderItemByIDData $OrderItemByIDDataFromJson(Map<String, dynamic> json) {
  final OrderItemByIDData orderItemByIDData = OrderItemByIDData();
  final OrderItemByIDDataCartOrder? cartOrder = jsonConvert.convert<
      OrderItemByIDDataCartOrder>(json['cart_order']);
  if (cartOrder != null) {
    orderItemByIDData.cartOrder = cartOrder;
  }
  final OrderItemByIDDataCartStock? cartStock = jsonConvert.convert<
      OrderItemByIDDataCartStock>(json['cart_stock']);
  if (cartStock != null) {
    orderItemByIDData.cartStock = cartStock;
  }
  final OrderItemByIDDataCartProduct? cartProduct = jsonConvert.convert<
      OrderItemByIDDataCartProduct>(json['cart_product']);
  if (cartProduct != null) {
    orderItemByIDData.cartProduct = cartProduct;
  }
  return orderItemByIDData;
}

Map<String, dynamic> $OrderItemByIDDataToJson(OrderItemByIDData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['cart_order'] = entity.cartOrder?.toJson();
  data['cart_stock'] = entity.cartStock?.toJson();
  data['cart_product'] = entity.cartProduct?.toJson();
  return data;
}

extension OrderItemByIDDataExtension on OrderItemByIDData {
  OrderItemByIDData copyWith({
    OrderItemByIDDataCartOrder? cartOrder,
    OrderItemByIDDataCartStock? cartStock,
    OrderItemByIDDataCartProduct? cartProduct,
  }) {
    return OrderItemByIDData()
      ..cartOrder = cartOrder ?? this.cartOrder
      ..cartStock = cartStock ?? this.cartStock
      ..cartProduct = cartProduct ?? this.cartProduct;
  }
}

OrderItemByIDDataCartOrder $OrderItemByIDDataCartOrderFromJson(
    Map<String, dynamic> json) {
  final OrderItemByIDDataCartOrder orderItemByIDDataCartOrder = OrderItemByIDDataCartOrder();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderItemByIDDataCartOrder.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    orderItemByIDDataCartOrder.productId = productId;
  }
  final String? quantity = jsonConvert.convert<String>(json['quantity']);
  if (quantity != null) {
    orderItemByIDDataCartOrder.quantity = quantity;
  }
  final String? price = jsonConvert.convert<String>(json['price']);
  if (price != null) {
    orderItemByIDDataCartOrder.price = price;
  }
  final String? stockid = jsonConvert.convert<String>(json['stockid']);
  if (stockid != null) {
    orderItemByIDDataCartOrder.stockid = stockid;
  }
  final String? netpayablecommission = jsonConvert.convert<String>(
      json['netpayablecommission']);
  if (netpayablecommission != null) {
    orderItemByIDDataCartOrder.netpayablecommission = netpayablecommission;
  }
  final String? sponsorCasback = jsonConvert.convert<String>(
      json['sponsor_casback']);
  if (sponsorCasback != null) {
    orderItemByIDDataCartOrder.sponsorCasback = sponsorCasback;
  }
  final String? orderId = jsonConvert.convert<String>(json['order_id']);
  if (orderId != null) {
    orderItemByIDDataCartOrder.orderId = orderId;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    orderItemByIDDataCartOrder.status = status;
  }
  final dynamic statusUpdDate = json['status_upd_date'];
  if (statusUpdDate != null) {
    orderItemByIDDataCartOrder.statusUpdDate = statusUpdDate;
  }
  final String? orderItemStatus = jsonConvert.convert<String>(
      json['order_item_status']);
  if (orderItemStatus != null) {
    orderItemByIDDataCartOrder.orderItemStatus = orderItemStatus;
  }
  final String? orderItemUpdDate = jsonConvert.convert<String>(
      json['order_item_upd_date']);
  if (orderItemUpdDate != null) {
    orderItemByIDDataCartOrder.orderItemUpdDate = orderItemUpdDate;
  }
  final String? userId = jsonConvert.convert<String>(json['user_id']);
  if (userId != null) {
    orderItemByIDDataCartOrder.userId = userId;
  }
  return orderItemByIDDataCartOrder;
}

Map<String, dynamic> $OrderItemByIDDataCartOrderToJson(
    OrderItemByIDDataCartOrder entity) {
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
  data['order_item_upd_date'] = entity.orderItemUpdDate;
  data['user_id'] = entity.userId;
  return data;
}

extension OrderItemByIDDataCartOrderExtension on OrderItemByIDDataCartOrder {
  OrderItemByIDDataCartOrder copyWith({
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
    String? orderItemUpdDate,
    String? userId,
  }) {
    return OrderItemByIDDataCartOrder()
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
      ..orderItemUpdDate = orderItemUpdDate ?? this.orderItemUpdDate
      ..userId = userId ?? this.userId;
  }
}

OrderItemByIDDataCartStock $OrderItemByIDDataCartStockFromJson(
    Map<String, dynamic> json) {
  final OrderItemByIDDataCartStock orderItemByIDDataCartStock = OrderItemByIDDataCartStock();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderItemByIDDataCartStock.id = id;
  }
  final String? productId = jsonConvert.convert<String>(json['product_id']);
  if (productId != null) {
    orderItemByIDDataCartStock.productId = productId;
  }
  final String? vendorId = jsonConvert.convert<String>(json['vendor_id']);
  if (vendorId != null) {
    orderItemByIDDataCartStock.vendorId = vendorId;
  }
  final String? currentQty = jsonConvert.convert<String>(json['current_qty']);
  if (currentQty != null) {
    orderItemByIDDataCartStock.currentQty = currentQty;
  }
  final String? priceStock = jsonConvert.convert<String>(json['price_stock']);
  if (priceStock != null) {
    orderItemByIDDataCartStock.priceStock = priceStock;
  }
  final String? mrp = jsonConvert.convert<String>(json['mrp']);
  if (mrp != null) {
    orderItemByIDDataCartStock.mrp = mrp;
  }
  final String? savecartPrice = jsonConvert.convert<String>(
      json['savecart_price']);
  if (savecartPrice != null) {
    orderItemByIDDataCartStock.savecartPrice = savecartPrice;
  }
  final String? ppRedemption = jsonConvert.convert<String>(
      json['pp_redemption']);
  if (ppRedemption != null) {
    orderItemByIDDataCartStock.ppRedemption = ppRedemption;
  }
  final String? priceSales = jsonConvert.convert<String>(json['price_sales']);
  if (priceSales != null) {
    orderItemByIDDataCartStock.priceSales = priceSales;
  }
  final String? igst = jsonConvert.convert<String>(json['igst']);
  if (igst != null) {
    orderItemByIDDataCartStock.igst = igst;
  }
  final String? sgst = jsonConvert.convert<String>(json['sgst']);
  if (sgst != null) {
    orderItemByIDDataCartStock.sgst = sgst;
  }
  final String? csgt = jsonConvert.convert<String>(json['csgt']);
  if (csgt != null) {
    orderItemByIDDataCartStock.csgt = csgt;
  }
  final String? igstAmt = jsonConvert.convert<String>(json['igst_amt']);
  if (igstAmt != null) {
    orderItemByIDDataCartStock.igstAmt = igstAmt;
  }
  final String? sgstAmt = jsonConvert.convert<String>(json['sgst_amt']);
  if (sgstAmt != null) {
    orderItemByIDDataCartStock.sgstAmt = sgstAmt;
  }
  final String? cgstAmt = jsonConvert.convert<String>(json['cgst_amt']);
  if (cgstAmt != null) {
    orderItemByIDDataCartStock.cgstAmt = cgstAmt;
  }
  final String? priceWithoutGst = jsonConvert.convert<String>(
      json['price_without_gst']);
  if (priceWithoutGst != null) {
    orderItemByIDDataCartStock.priceWithoutGst = priceWithoutGst;
  }
  final String? margin = jsonConvert.convert<String>(json['margin']);
  if (margin != null) {
    orderItemByIDDataCartStock.margin = margin;
  }
  final String? genShareAmt = jsonConvert.convert<String>(
      json['gen_share_amt']);
  if (genShareAmt != null) {
    orderItemByIDDataCartStock.genShareAmt = genShareAmt;
  }
  final String? cashBack = jsonConvert.convert<String>(json['cash_back']);
  if (cashBack != null) {
    orderItemByIDDataCartStock.cashBack = cashBack;
  }
  final String? stockEntryDate = jsonConvert.convert<String>(
      json['stock_entry_date']);
  if (stockEntryDate != null) {
    orderItemByIDDataCartStock.stockEntryDate = stockEntryDate;
  }
  return orderItemByIDDataCartStock;
}

Map<String, dynamic> $OrderItemByIDDataCartStockToJson(
    OrderItemByIDDataCartStock entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = entity.id;
  data['product_id'] = entity.productId;
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

extension OrderItemByIDDataCartStockExtension on OrderItemByIDDataCartStock {
  OrderItemByIDDataCartStock copyWith({
    String? id,
    String? productId,
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
    return OrderItemByIDDataCartStock()
      ..id = id ?? this.id
      ..productId = productId ?? this.productId
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

OrderItemByIDDataCartProduct $OrderItemByIDDataCartProductFromJson(
    Map<String, dynamic> json) {
  final OrderItemByIDDataCartProduct orderItemByIDDataCartProduct = OrderItemByIDDataCartProduct();
  final String? id = jsonConvert.convert<String>(json['id']);
  if (id != null) {
    orderItemByIDDataCartProduct.id = id;
  }
  final String? productName = jsonConvert.convert<String>(json['product_name']);
  if (productName != null) {
    orderItemByIDDataCartProduct.productName = productName;
  }
  final String? categoryId = jsonConvert.convert<String>(json['category_id']);
  if (categoryId != null) {
    orderItemByIDDataCartProduct.categoryId = categoryId;
  }
  final String? subCategoryId = jsonConvert.convert<String>(
      json['sub_category_id']);
  if (subCategoryId != null) {
    orderItemByIDDataCartProduct.subCategoryId = subCategoryId;
  }
  final String? productDescription = jsonConvert.convert<String>(
      json['product_description']);
  if (productDescription != null) {
    orderItemByIDDataCartProduct.productDescription = productDescription;
  }
  final String? productSpec = jsonConvert.convert<String>(json['product_spec']);
  if (productSpec != null) {
    orderItemByIDDataCartProduct.productSpec = productSpec;
  }
  final String? primeImage = jsonConvert.convert<String>(json['prime_image']);
  if (primeImage != null) {
    orderItemByIDDataCartProduct.primeImage = primeImage;
  }
  final String? sideImage1 = jsonConvert.convert<String>(json['side_image1']);
  if (sideImage1 != null) {
    orderItemByIDDataCartProduct.sideImage1 = sideImage1;
  }
  final String? sideImage2 = jsonConvert.convert<String>(json['side_image2']);
  if (sideImage2 != null) {
    orderItemByIDDataCartProduct.sideImage2 = sideImage2;
  }
  final dynamic sideImage3 = json['side_image3'];
  if (sideImage3 != null) {
    orderItemByIDDataCartProduct.sideImage3 = sideImage3;
  }
  final dynamic sideImage4 = json['side_image4'];
  if (sideImage4 != null) {
    orderItemByIDDataCartProduct.sideImage4 = sideImage4;
  }
  final dynamic unitId = json['unit_id'];
  if (unitId != null) {
    orderItemByIDDataCartProduct.unitId = unitId;
  }
  final String? sizeEnabled = jsonConvert.convert<String>(json['size_enabled']);
  if (sizeEnabled != null) {
    orderItemByIDDataCartProduct.sizeEnabled = sizeEnabled;
  }
  final String? colorEnabled = jsonConvert.convert<String>(
      json['color_enabled']);
  if (colorEnabled != null) {
    orderItemByIDDataCartProduct.colorEnabled = colorEnabled;
  }
  final dynamic color = json['color'];
  if (color != null) {
    orderItemByIDDataCartProduct.color = color;
  }
  final dynamic size = json['size'];
  if (size != null) {
    orderItemByIDDataCartProduct.size = size;
  }
  final dynamic vendorId = json['vendor_id'];
  if (vendorId != null) {
    orderItemByIDDataCartProduct.vendorId = vendorId;
  }
  final String? returnPolicyId = jsonConvert.convert<String>(
      json['return_policy_id']);
  if (returnPolicyId != null) {
    orderItemByIDDataCartProduct.returnPolicyId = returnPolicyId;
  }
  final String? offeredItemStatus = jsonConvert.convert<String>(
      json['offered_item_status']);
  if (offeredItemStatus != null) {
    orderItemByIDDataCartProduct.offeredItemStatus = offeredItemStatus;
  }
  final String? status = jsonConvert.convert<String>(json['status']);
  if (status != null) {
    orderItemByIDDataCartProduct.status = status;
  }
  final String? returnable = jsonConvert.convert<String>(json['returnable']);
  if (returnable != null) {
    orderItemByIDDataCartProduct.returnable = returnable;
  }
  return orderItemByIDDataCartProduct;
}

Map<String, dynamic> $OrderItemByIDDataCartProductToJson(
    OrderItemByIDDataCartProduct entity) {
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
  return data;
}

extension OrderItemByIDDataCartProductExtension on OrderItemByIDDataCartProduct {
  OrderItemByIDDataCartProduct copyWith({
    String? id,
    String? productName,
    String? categoryId,
    String? subCategoryId,
    String? productDescription,
    String? productSpec,
    String? primeImage,
    String? sideImage1,
    String? sideImage2,
    dynamic sideImage3,
    dynamic sideImage4,
    dynamic unitId,
    String? sizeEnabled,
    String? colorEnabled,
    dynamic color,
    dynamic size,
    dynamic vendorId,
    String? returnPolicyId,
    String? offeredItemStatus,
    String? status,
    String? returnable,
  }) {
    return OrderItemByIDDataCartProduct()
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
      ..returnable = returnable ?? this.returnable;
  }
}