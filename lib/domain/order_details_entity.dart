import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/order_details_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/order_details_entity.g.dart';

@JsonSerializable()
class OrderDetailsEntity {
	int? status = 0;
	String? message = '';
	@JSONField(name: "server_date")
	String? serverDate = '';
	List<OrderDetailsData>? data = [];

	OrderDetailsEntity();

	factory OrderDetailsEntity.fromJson(Map<String, dynamic> json) => $OrderDetailsEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsData {
	@JSONField(name: "cart_order")
	OrderDetailsDataCartOrder? cartOrder=new OrderDetailsDataCartOrder();
	@JSONField(name: "cart_stock")
	OrderDetailsDataCartStock? cartStock=new OrderDetailsDataCartStock();
	@JSONField(name: "cart_product")
	OrderDetailsDataCartProduct? cartProduct=new OrderDetailsDataCartProduct();
	@JSONField(name: "payment_details")
	OrderDetailsDataPaymentDetails? paymentDetails=new OrderDetailsDataPaymentDetails();
	@JSONField(name: "cart_return_requests")
	OrderDetailsDataCartReturnRequests? cartReturnRequests=new OrderDetailsDataCartReturnRequests();

	OrderDetailsData();

	factory OrderDetailsData.fromJson(Map<String, dynamic> json) => $OrderDetailsDataFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsDataCartOrder {
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
	@JSONField(name: "initiate_confirm")
	String? initiateConfirm = '';
	@JSONField(name: "order_item_upd_date")
	String? orderItemUpdDate = '';
	@JSONField(name: "user_id")
	String? userId = '';
	@JSONField(name: "update_by")
	dynamic updateBy;
	@JSONField(name: "vendor_confirmation_updated_by")
	String? vendorConfirmationUpdatedBy = '';
	@JSONField(name: "vendor_confirmation_updated_at")
	String? vendorConfirmationUpdatedAt = '';
	@JSONField(name: "packing_empoyee_id")
	String? packingEmpoyeeId = '';
	@JSONField(name: "packed_at")
	String? packedAt = '';
	@JSONField(name: "invoice_status")
	String? invoiceStatus = '';
	@JSONField(name: "shipped_emp_id")
	dynamic shippedEmpId;
	@JSONField(name: "shipped_at")
	dynamic shippedAt;
	@JSONField(name: "delivering_agency_id")
	dynamic deliveringAgencyId;
	@JSONField(name: "pod_number")
	dynamic podNumber;
	@JSONField(name: "delivery_status_from_agency")
	String? deliveryStatusFromAgency = '';
	@JSONField(name: "delivery_recved_date_from_agency")
	dynamic deliveryRecvedDateFromAgency;
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "cancelled_at")
	String? cancelledAt = '';

	OrderDetailsDataCartOrder();

	factory OrderDetailsDataCartOrder.fromJson(Map<String, dynamic> json) => $OrderDetailsDataCartOrderFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataCartOrderToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsDataCartStock {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "d_type")
	dynamic dType;
	@JSONField(name: "proid_from")
	dynamic proidFrom;
	dynamic sz;
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

	OrderDetailsDataCartStock();

	factory OrderDetailsDataCartStock.fromJson(Map<String, dynamic> json) => $OrderDetailsDataCartStockFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataCartStockToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsDataCartProduct {
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
	String? sideImage3 = '';
	@JSONField(name: "side_image4")
	String? sideImage4 = '';
	@JSONField(name: "unit_id")
	String? unitId = '';
	@JSONField(name: "size_enabled")
	String? sizeEnabled = '';
	@JSONField(name: "color_enabled")
	String? colorEnabled = '';
	String? color = '';
	String? size = '';
	@JSONField(name: "vendor_id")
	String? vendorId = '';
	@JSONField(name: "return_policy_id")
	String? returnPolicyId = '';
	@JSONField(name: "offered_item_status")
	String? offeredItemStatus = '';
	String? status = '';
	String? returnable = '';
	@JSONField(name: "return_days")
	String? returnDays = '';
	@JSONField(name: "product_code")
	String? productCode = '';

	OrderDetailsDataCartProduct();

	factory OrderDetailsDataCartProduct.fromJson(Map<String, dynamic> json) => $OrderDetailsDataCartProductFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataCartProductToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsDataPaymentDetails {
	String? id = '';
	@JSONField(name: "reg_id")
	String? regId = '';
	@JSONField(name: "date_order")
	String? dateOrder = '';
	@JSONField(name: "delivery_date")
	dynamic deliveryDate;
	@JSONField(name: "address_id")
	String? addressId = '';
	String? totalprice = '';
	String? isWalletUsed = '';
	@JSONField(name: "paid_amount")
	String? paidAmount = '';
	@JSONField(name: "used_wallet_amount")
	String? usedWalletAmount = '';
	@JSONField(name: "payment_type")
	String? paymentType = '';
	@JSONField(name: "transaction_id")
	String? transactionId = '';
	@JSONField(name: "transaction_details")
	String? transactionDetails = '';
	@JSONField(name: "billing_status")
	String? billingStatus = '';
	String? description = '';
	@JSONField(name: "payment_status")
	String? paymentStatus = '';

	OrderDetailsDataPaymentDetails();

	factory OrderDetailsDataPaymentDetails.fromJson(Map<String, dynamic> json) => $OrderDetailsDataPaymentDetailsFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataPaymentDetailsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderDetailsDataCartReturnRequests {
	String? id = '';
	@JSONField(name: "product_id")
	String? productId = '';
	@JSONField(name: "product_return_policy_id")
	String? productReturnPolicyId = '';
	@JSONField(name: "order_id")
	String? orderId = '';
	String? image1 = '';
	String? image2 = '';
	String? image3 = '';
	@JSONField(name: "user_id")
	String? userId = '';
	String? reason = '';
	@JSONField(name: "created_at")
	String? createdAt = '';
	@JSONField(name: "refunded_date")
	String? refundedDate = '';
	String? status = '';
	@JSONField(name: "refund_status")
	String? refundStatus = '';

	OrderDetailsDataCartReturnRequests();

	factory OrderDetailsDataCartReturnRequests.fromJson(Map<String, dynamic> json) => $OrderDetailsDataCartReturnRequestsFromJson(json);

	Map<String, dynamic> toJson() => $OrderDetailsDataCartReturnRequestsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}