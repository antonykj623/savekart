import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:savekart/design/ResponsiveInfo.dart';

import '../web/encrypthelper.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanned = false;

  void onQRDetected(BarcodeCapture capture) {
    if (isScanned) {
      return;
    }

    final List<Barcode> barcodes = capture.barcodes;

    if (barcodes.isEmpty) {
      return;
    }

    final String? value = barcodes.first.rawValue;

    if (value == null || value.isEmpty) {
      return;
    }

    isScanned = true;

    debugPrint('QR Result: $value');

    try {
      final decrypted =
      EncryptionHelper.decryptText(value);

      debugPrint('Decrypted QR: $decrypted');

      ResponsiveInfo.showAlertDialog(context,"",value.toString()+"\n\n"+decrypted);

      Navigator.pop(context, decrypted);
    } catch (e) {
      isScanned = false;

      debugPrint('Invalid QR: $e');
    }




   // Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),

      body: Stack(
        children: [

          MobileScanner(
            onDetect: onQRDetected,
          ),

          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Scan QR Code',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}