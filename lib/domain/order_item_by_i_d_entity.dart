import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/order_item_by_i_d_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/order_item_by_i_d_entity.g.dart';

@JsonSerializable()
class OrderItemByIDEntity {
	int? status = 0;
	String? message = '';
	OrderItemByIDData? data;

	OrderItemByIDEntity();

	factory OrderItemByIDEntity.fromJson(Map<String, dynamic> json) => $OrderItemByIDEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderItemByIDEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderItemByIDData {
	@JSONField(name: "cart_order")
	OrderItemByIDDataCartOrder? cartOrder;
	@JSONField(name: "cart_stock")
	OrderItemByIDDataCartStock? cartStock;
	@JSONField(name: "cart_product")
	OrderItemByIDDataCartProduct? cartProduct;

	OrderItemByIDData();

	factory OrderItemByIDData.fromJson(Map<String, dynamic> json) => $OrderItemByIDDataFromJson(json);

	Map<String, dynamic> toJson() => $OrderItemByIDDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderItemByIDDataCartOrder {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	String? quantity = '';
	String? price = '';
	String? stockid = '';
	String? netpayablecommission = '';
	@JSONField(name: "sponsor_casback")
	String? sponsorCasback = '';
	@JSONField(name: "order_id")
	String? orderId = '';
	String? status = '';
	@JSONField(name: "status_upd_date")
	dynamic statusUpdDate;
	@JSONField(name: "order_item_status")
	String? orderItemStatus = '';
	@JSONField(name: "order_item_upd_date")
	String? orderItemUpdDate = '';
	@JSONField(name: "user_id")
	String? userId = '';

	OrderItemByIDDataCartOrder();

	factory OrderItemByIDDataCartOrder.fromJson(Map<String, dynamic> json) => $OrderItemByIDDataCartOrderFromJson(json);

	Map<String, dynamic> toJson() => $OrderItemByIDDataCartOrderToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderItemByIDDataCartStock {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "vendor_id")
	String? vendorId = '';
	@JSONField(name: "current_qty")
	String? currentQty = '';
	@JSONField(name: "price_stock")
	String? priceStock = '';
	String? mrp = '';
	@JSONField(name: "savecart_price")
	String? savecartPrice = '';
	@JSONField(name: "pp_redemption")
	String? ppRedemption = '';
	@JSONField(name: "price_sales")
	String? priceSales = '';
	String? igst = '';
	String? sgst = '';
	String? csgt = '';
	@JSONField(name: "igst_amt")
	String? igstAmt = '';
	@JSONField(name: "sgst_amt")
	String? sgstAmt = '';
	@JSONField(name: "cgst_amt")
	String? cgstAmt = '';
	@JSONField(name: "price_without_gst")
	String? priceWithoutGst = '';
	String? margin = '';
	@JSONField(name: "gen_share_amt")
	String? genShareAmt = '';
	@JSONField(name: "cash_back")
	String? cashBack = '';
	@JSONField(name: "stock_entry_date")
	String? stockEntryDate = '';

	OrderItemByIDDataCartStock();

	factory OrderItemByIDDataCartStock.fromJson(Map<String, dynamic> json) => $OrderItemByIDDataCartStockFromJson(json);

	Map<String, dynamic> toJson() => $OrderItemByIDDataCartStockToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderItemByIDDataCartProduct {
	String? id = '';
	@JSONField(name: "product_name")
	String? productName = '';
	@JSONField(name: "category_id")
	String? categoryId = '';
	@JSONField(name: "sub_category_id")
	String? subCategoryId = '';
	@JSONField(name: "product_description")
	String? productDescription = '';
	@JSONField(name: "product_spec")
	String? productSpec = '';
	@JSONField(name: "prime_image")
	String? primeImage = '';
	@JSONField(name: "side_image1")
	String? sideImage1 = '';
	@JSONField(name: "side_image2")
	String? sideImage2 = '';
	@JSONField(name: "side_image3")
	dynamic sideImage3;
	@JSONField(name: "side_image4")
	dynamic sideImage4;
	@JSONField(name: "unit_id")
	dynamic unitId;
	@JSONField(name: "size_enabled")
	String? sizeEnabled = '';
	@JSONField(name: "color_enabled")
	String? colorEnabled = '';
	dynamic color;
	dynamic size;
	@JSONField(name: "vendor_id")
	dynamic vendorId;
	@JSONField(name: "return_policy_id")
	String? returnPolicyId = '';
	@JSONField(name: "offered_item_status")
	String? offeredItemStatus = '';
	String? status = '';
	String? returnable = '';

	OrderItemByIDDataCartProduct();

	factory OrderItemByIDDataCartProduct.fromJson(Map<String, dynamic> json) => $OrderItemByIDDataCartProductFromJson(json);

	Map<String, dynamic> toJson() => $OrderItemByIDDataCartProductToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}