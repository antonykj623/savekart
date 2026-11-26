import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/domain/return_policy_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/app_version_entity.dart';
import '../../domain/order_details_entity.dart';
import '../../domain/profile_data_entity.dart';
import '../../web/api_helper.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../order_details.dart';
import '../uploadPhotosToReturn.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  List<OrderDetailsData>? data = [];
  String serverdate = "";
  String name = "", regid = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllOrders();
    getAppUpdates();
    getProfile();
  }

  Future<void> getProfile() async {
    try {
      final Map<String, String> m = HashMap();
      final apiHelper = ApiHelper();
      final response =
      await apiHelper.post(Apimethodes.getUserDetails, formDataPayload: m);
      final js = jsonDecode(jsonDecode(response));
      final entity = ProfileDataEntity.fromJson(js);

      if (!mounted) return;
      if (entity.status == 1 && entity.data != null) {
        setState(() {
          name = entity.data!.fullName.toString();
          regid = entity.data!.regCode.toString();
        });
      }
    } catch (_) {
      // Keep UI usable if profile lookup fails.
    }
  }

  Future<void> getAppUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = double.tryParse(packageInfo.version) ?? 0.0;

      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response1 =
      await apiHelper.get("${Apimethodes.getCartUpdate}?q=$t");
      final appVersion = AppVersionEntity.fromJson(jsonDecode(response1));

      if (!mounted || appVersion.status != 1 || appVersion.data == null) {
        return;
      }

      final versionFromServer = appVersion.data!.version.toString();
      final appVersionFromServer = double.tryParse(versionFromServer) ?? 0.0;

      if (appVersionFromServer > currentVersion && mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              "App Version",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text("New version: $versionFromServer is available"),
            actions: [
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.integra.savekart",
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    throw "Could not launch $url";
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                    color: primaryTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (_) {
      // Keep UI usable if update check fails.
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);
    final ordersList = data ?? [];

    return Scaffold(
      backgroundColor: surfaceBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Orders',
          style: TextStyle(
            color: Color(0xFF1A1D1F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            tooltip: "Refresh",
            icon: const Icon(Icons.refresh_rounded, color: primaryTeal),
            onPressed: () => getAllOrders(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryTeal))
          : ordersList.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 10),
            const Text(
              "No orders found",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        color: primaryTeal,
        onRefresh: () => getAllOrders(),
        child: ListView.separated(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          itemCount: ordersList.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
              _buildOrderCard(ordersList[index], isMobile),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderDetailsData item, bool isMobile) {
    final order = item.cartOrder!;
    final product = item.cartProduct!;
    final returnRequest = item.cartReturnRequests!;
    final paymentDetails = item.paymentDetails!;
    final isPaymentOk = paymentDetails.paymentStatus.toString() == "1";

    final statusSummary = _getPrimaryStatus(order, paymentDetails);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => OrderItemDetailsScreen(item)),
        ),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order #${order.orderId ?? ''}",
                    style: TextStyle(
                      fontSize: isMobile ? 12.5 : 13.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusSummary.color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusSummary.label,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: statusSummary.color,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: isMobile ? 64 : 78,
                    height: isMobile ? 64 : 78,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: surfaceBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      EcommerceApiHelper.productimageurl +
                          product.primeImage.toString(),
                      fit: BoxFit.contain,
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primaryTeal,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_outlined,
                        size: 36,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isMobile ? 14.5 : 16,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1D1F),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Price: ${order.price} Rs",
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: primaryTeal,
                          ),
                        ),
                        if (name.isNotEmpty || regid.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            [
                              if (name.isNotEmpty) name,
                              if (regid.isNotEmpty) "ID: $regid",
                            ].join(" • "),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
              if (!isPaymentOk) ...[
                const SizedBox(height: 10),
                _buildStatusBanner("Payment failed", Colors.red.shade700),
              ] else ...[
                if (order.status.toString() == "1") ...[
                  const SizedBox(height: 8),
                  _buildStatusBanner(
                    "Accepted this order item",
                    Colors.green.shade700,
                  ),
                ],
                if (order.status.toString() == "2") ...[
                  const SizedBox(height: 8),
                  _buildStatusBanner(
                    "Rejected this order item",
                    Colors.redAccent,
                  ),
                ],
                if (returnRequest.status.toString() == "0" &&
                    returnRequest.refundStatus.toString() == "0") ...[
                  const SizedBox(height: 8),
                  _buildStatusBanner(
                    "You have submitted a return request on ${getFormatedDate(returnRequest.createdAt.toString())}",
                    primaryTeal,
                  ),
                ],
                if (returnRequest.status.toString() == "1") ...[
                  const SizedBox(height: 8),
                  _buildStatusBanner(
                    "Your return request accepted" +
                        (returnRequest.refundStatus.toString() == "1"
                            ? "\nRefunded on ${returnRequest.refundedDate != null ? getFormatedDate(returnRequest.refundedDate.toString()) : ""}"
                            : "\nNot Refunded"),
                    Colors.redAccent,
                  ),
                ],
                if (order.status.toString() == "0" &&
                    order.orderItemStatus.toString() == "0") ...[
                  const SizedBox(height: 12),
                  _buildActionButton(
                    text: "Cancel Order",
                    bgColor: Colors.white,
                    textColor: primaryTeal,
                    isMobile: isMobile,
                    onPressed: () => _showConfirmationDialog(
                      context,
                      "Do you want to cancel this order item?",
                          () => updateOrderCancelStatus(order.id.toString()),
                    ),
                  ),
                ],
                if (order.status.toString() == "0" &&
                    order.orderItemStatus.toString() == "3" &&
                    isEligibleToShowAcceptReturn(item) &&
                    returnRequest.id.toString().isEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          text: "Reject / Return",
                          bgColor: Colors.white,
                          textColor: primaryTeal,
                          isMobile: isMobile,
                          onPressed: () => _showConfirmationDialog(
                            context,
                            "Do you want to return this order item?",
                                () => getReturnPolicies(
                              order.productId.toString(),
                              item,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildActionButton(
                          text: "Accept",
                          bgColor: primaryTeal,
                          textColor: Colors.white,
                          isMobile: isMobile,
                          onPressed: () =>
                              updateOrderAcceptStatus(order.id.toString()),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  ({String label, Color color}) _getPrimaryStatus(
      dynamic order,
      dynamic paymentDetails,
      ) {
    if (paymentDetails.paymentStatus.toString() != "1") {
      return (label: "Payment Failed", color: Colors.red.shade700);
    }
    switch (order.orderItemStatus.toString()) {
      case "0":
        return (label: "Order Created", color: Colors.green.shade700);
      case "1":
        return (label: "Packing in Progress", color: Colors.green.shade700);
      case "2":
        return (label: "Out for Delivery", color: Colors.green.shade700);
      case "3":
        return (label: "Delivered", color: Colors.green.shade700);
      case "4":
        return (label: "Returned", color: Colors.redAccent);
      case "5":
        return (label: "Cancelled", color: Colors.red.shade700);
      default:
        return (label: "Processing", color: primaryTeal);
    }
  }

  Widget _buildStatusBanner(String text, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    required bool isMobile,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: isMobile ? 42 : 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: primaryTeal, width: 1),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 13 : 14.5,
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context,
      String message,
      VoidCallback onConfirm,
      ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Savekart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("No", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          TextButton(
            child: const Text(
              "Yes",
              style: TextStyle(color: primaryTeal, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
              onConfirm();
            },
          ),
        ],
      ),
    );
  }

  String getFormatedDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateTime);
    } catch (_) {
      return dateString;
    }
  }

  Future<void> updateOrderCancelStatus(String orderid) async {
    ResponsiveInfo.ShowProgressDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    await apiHelper
        .get("${Apimethodes.UpdateOrderCancel}?q=$t&id=$orderid");
    if (!mounted) return;
    Navigator.pop(context);
    await getAllOrders();
  }

  Future<void> updateOrderAcceptStatus(String orderid) async {
    ResponsiveInfo.ShowProgressDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    await apiHelper
        .get("${Apimethodes.updateAcceptStatus}?q=$t&id=$orderid");
    if (!mounted) return;
    Navigator.pop(context);
    await getAllOrders();
  }

  Future<void> getAllOrders() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    try {
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response =
      await apiHelper.get("${Apimethodes.getOrderItems}?q=$t");
      final js = jsonDecode(response);
      final entity = OrderDetailsEntity.fromJson(js);

      if (!mounted) return;

      if (entity.status == 1) {
        serverdate = entity.serverDate ?? "";
        final items = entity.data ?? [];
        setState(() {
          data = items.reversed.toList();
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  Future<void> getReturnPolicies(
      String product_id,
      OrderDetailsData ord,
      ) async {
    ResponsiveInfo.showLoaderDialog(context);
    final apiHelper = EcommerceApiHelper();
    final t = EcommerceApiHelper.getTimeStamp();
    final response = await apiHelper.get(
      "${Apimethodes.getReturnPolicyData}?q=$t&product_id=$product_id",
    );

    if (!mounted) return;
    Navigator.pop(context);

    final js = jsonDecode(response);
    final entity = ReturnPolicyEntity.fromJson(js);

    if (entity.status == 1 && entity.data != null) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Savekart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "${entity.data!.policy}\n\nDo you want to continue?",
          ),
          actions: [
            TextButton(
              child: const Text("No", style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            TextButton(
              child: const Text(
                "Yes",
                style:
                TextStyle(color: primaryTeal, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReturnProductImagePickerWidget(
                      product_id,
                      entity.data!.policyId.toString(),
                      ord,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    } else {
      ResponsiveInfo.showAlertDialog(
        context,
        "",
        "Error while fetching Return Policy of this product",
      );
    }
  }

  bool isEligibleToShowAcceptReturn(OrderDetailsData data) {
    if (serverdate.isEmpty) return false;
    final receivedDateStr =
        data.cartOrder?.deliveryRecvedDateFromAgency?.toString() ?? "";
    if (receivedDateStr.isEmpty) return false;
    if (data.cartProduct?.returnable.toString() != "1") return false;

    final daysStr = data.cartProduct?.returnDays ?? "";
    final days = int.tryParse(daysStr);
    if (days == null) return false;

    try {
      final sDateTime = DateFormat("yyyy-MM-dd hh:mm:ss a").parse(serverdate);
      final oDateTime = DateTime.parse(receivedDateStr);
      final dtAfterReturnTime = oDateTime.add(Duration(days: days));
      return !sDateTime.isAfter(dtAfterReturnTime);
    } catch (_) {
      return false;
    }
  }
}