import 'package:flutter/material.dart';

import 'order_status_step.dart';

class OrderStatus extends StatelessWidget {
   OrderStatus() ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderStatusStep(title: 'Processing', isActive: true),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
        OrderStatusStep(title: 'Picking', isActive: false),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
        OrderStatusStep(title: 'Shipping', isActive: false),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey,
          ),
        ),
        OrderStatusStep(title: 'Delivered', isActive: false),
      ],
    );
  }
}
