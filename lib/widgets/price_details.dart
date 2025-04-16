
import 'package:flutter/material.dart';
import 'package:savekart/widgets/price_detail_item.dart';

class PriceDetails extends StatelessWidget {
   PriceDetails();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            PriceDetailItem(title: 'Original Price', value: '\$3.20'),
            PriceDetailItem(title: 'Offer Price', value: '\$2.50'),
            PriceDetailItem(title: 'Quantity', value: '2'),
            PriceDetailItem(title: 'Delivery Charge', value: 'Free'),
            Divider(),
            PriceDetailItem(title: 'SUB TOTAL', value: '\$5.00', isBold: true),
          ],
        ),
      ),
    );
  }
}
