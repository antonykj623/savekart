
import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';

class OrderStatusStep extends StatelessWidget {
  final String title;
  final bool isActive;

  OrderStatusStep({required this.title, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: ResponsiveInfo.isMobile(context)?8:13,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: isActive ? Icon(Icons.check, color: Colors.white,size: ResponsiveInfo.isMobile(context)?11:16,) : null,
        ),
        SizedBox(height: 4),
        Text(title),
      ],
    );
  }


}
