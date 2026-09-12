import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class QrScreen extends StatefulWidget {
  final String qrString;

  const QrScreen({
    super.key,
    required this.qrString,
  });

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {

  @override
  void initState() {
    super.initState();

    // Prevent screenshots / screen recording

  }

  @override
  void dispose() {
    // Restore normal UI


    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title:  Text("Event ticket QR Code",style: TextStyle(fontSize: 14),),
      ),

      body: Center(
        child:

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            QrImageView(
              data: widget.qrString,
              version: QrVersions.auto,
              size: 280,
              backgroundColor: Colors.white,
            ),

            Container(height: 15,),

            Text("Scan this QR code at the event venue to verify your ticket.",style: TextStyle(fontSize: 14),)

          ],
        )


      ),
    );
  }
}