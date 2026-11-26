import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/wallet_balance_entity.dart';
import 'package:savekart/domain/wallet_transaction_entity.dart';
import 'package:savekart/web/apimethodes.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';

class WalletTransaction extends StatefulWidget {
  const WalletTransaction({super.key});

  @override
  _WalletTransactionState createState() => _WalletTransactionState();
}

class _WalletTransactionState extends State<WalletTransaction> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  double walletbalance = 0.0;
  List<WalletTransactionData>? data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshWalletData();
  }

  Future<void> _refreshWalletData() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    await Future.wait([
      calculateWalletBalance(),
      getWalletTransactions(),
    ]);
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> calculateWalletBalance() async {
    try {
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response = await apiHelper.get(
        "${Apimethodes.calculateWalletBallence}?q=$t",
      );
      final js = jsonDecode(response);
      final entity = WalletBalanceEntity.fromJson(js);

      if (!mounted) return;
      if (entity.data?.balance != null) {
        setState(() {
          walletbalance =
              double.tryParse(entity.data!.balance.toString()) ?? 0.0;
        });
      }
    } catch (_) {
      // Keep UI usable if balance fetch fails.
    }
  }

  Future<void> getWalletTransactions() async {
    try {
      final apiHelper = EcommerceApiHelper();
      final t = EcommerceApiHelper.getTimeStamp();
      final response = await apiHelper.get(
        "${Apimethodes.getwalletTransactions}?q=$t",
      );
      final js = jsonDecode(response);
      final entity = WalletTransactionEntity.fromJson(js);

      if (!mounted) return;
      if (entity.status == 1 && entity.data != null) {
        setState(() {
          data = entity.data!.reversed.toList();
        });
      }
    } catch (_) {
      // Keep UI usable if transaction history fetch fails.
    }
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "";
    try {
      final dt = DateTime.parse(rawDate);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      return "$day-$month-${dt.year}";
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);
    final transactions = data ?? [];

    return Scaffold(
      backgroundColor: surfaceBg,
      appBar: AppBar(
        backgroundColor: primaryTeal,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: isMobile ? 20 : 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Savekart Wallet",
          style: TextStyle(
            fontSize: isMobile ? 15.5 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: primaryTeal,
        onRefresh: _refreshWalletData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBalanceCard(isMobile),
            Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 14 : 18,
                4,
                isMobile ? 14 : 18,
                8,
              ),
              child: Text(
                "Transaction History",
                style: TextStyle(
                  fontSize: isMobile ? 15 : 17,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1D1F),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(color: primaryTeal),
              )
                  : transactions.isEmpty
                  ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 44,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "No data found",
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  : ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 12 : 16,
                  2,
                  isMobile ? 12 : 16,
                  18,
                ),
                itemCount: transactions.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 10),
                itemBuilder: (context, index) =>
                    _buildTransactionTile(transactions[index], isMobile),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 12 : 16),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: primaryTeal,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: primaryTeal.withOpacity(0.22),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: isMobile ? 28 : 34,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Wallet Balance",
                  style: TextStyle(
                    fontSize: isMobile ? 12.5 : 14,
                    color: Colors.white.withOpacity(0.88),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  walletbalance.toString(),
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(WalletTransactionData txn, bool isMobile) {
    final isCredit =
        txn.debit.toString() == "0" && txn.credit.toString() != "0";
    final amountText = isCredit ? "+${txn.credit}" : "-${txn.debit}";
    final amountColor = isCredit ? Colors.green.shade700 : Colors.red.shade700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 38 : 42,
            height: isMobile ? 38 : 42,
            decoration: BoxDecoration(
              color: isCredit
                  ? const Color(0xFFEAF7EE)
                  : const Color(0xFFFFF1F2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit
                  ? Icons.south_west_rounded
                  : Icons.north_east_rounded,
              color: amountColor,
              size: isMobile ? 19 : 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  txn.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isMobile ? 13.5 : 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1D1F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(txn.transactionDate?.toString()),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            amountText,
            style: TextStyle(
              color: amountColor,
              fontSize: isMobile ? 14.5 : 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}