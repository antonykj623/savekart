import 'package:savekart/generated/json/base/json_field.dart';
import 'package:savekart/generated/json/product_stock_entity.g.dart';
import 'dart:convert';
export 'package:savekart/generated/json/product_stock_entity.g.dart';

@JsonSerializable()
class ProductStockEntity {
	int? status = 0;
	String? message = '';
	ProductStockData? data=new ProductStockData();

	ProductStockEntity();

	factory ProductStockEntity.fromJson(Map<String, dynamic> json) => $ProductStockEntityFromJson(json);

	Map<String, dynamic> toJson() => $ProductStockEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class ProductStockData {
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

	ProductStockData();

	factory ProductStockData.fromJson(Map<String, dynamic> json) => $ProductStockDataFromJson(json);

	Map<String, dynamic> toJson() => $ProductStockDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}