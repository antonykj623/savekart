import 'package:flutter/material.dart';

class PriceDetailItem extends StatelessWidget {


  final String title;
  final String value;
  final bool isBold;

  PriceDetailItem({required this.title, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
