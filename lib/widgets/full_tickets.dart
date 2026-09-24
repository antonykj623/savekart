import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:savekart/domain/userdata_entity.dart';
import 'package:savekart/web/encrypthelper.dart';
import 'package:savekart/widgets/searchuser.dart';
import '../design/ResponsiveInfo.dart';
import '../web/AppStorage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../web/SavekartApiHelper.dart';
import '../web/apimethodes.dart';

class TicketDetailsPage extends StatefulWidget {
  final String eventRefId;

  const TicketDetailsPage({
    super.key,
    required this.eventRefId,
  });

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  bool isLoading = true;
  String? errorMessage;

  List<dynamic> tickets = [];

  int totalCount = 0;
  int verifiedCount = 0;
  int unverifiedCount = 0;
  int sharedCount = 0;
  int notSharedCount = 0;
  final Map<String, GlobalKey> qrKeys = {};

  @override
  void initState() {
    super.initState();
    getTicketDatas();
  }

  Future<void> getTicketDatas() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      String? token = await AppStorage.getString(AppStorage.token);
      final url = Uri.parse(
        'https://mysaving.in/SavekartApi/getTicketDatas'
            '?eventRefId=${Uri.encodeComponent(widget.eventRefId)}',
      );

      final response = await http.get(
        url,
        headers: {

          'Authorization': token.toString() + '|' + timestamp.toString(),
    'timestamp': timestamp.toString(),

        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'].toString() == 'true') {
          setState(() {
            tickets = responseData['data'] ?? [];

            totalCount = tickets.length;

            verifiedCount = tickets.where(
                  (ticket) => ticket['verified'].toString() == '1',
            ).length;

            unverifiedCount = tickets.where(
                  (ticket) => ticket['verified'].toString() == '0',
            ).length;

            sharedCount = tickets.where(
                  (ticket) => ticket['shared'].toString() == '1',
            ).length;

            notSharedCount = tickets.where(
                  (ticket) => ticket['shared'].toString() == '0',
            ).length;

            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = responseData['message'] ?? 'No data found';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage =
          'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong: $e';
        isLoading = false;
      });
    }
  }

  Future<File?> generateQrFileFromString(String qrData, String ticketId) async {
    try {
      // 1. Create a QR painter instance directly from the string
      final painter = QrPainter(
        data: qrData,
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.H,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
      );

      // 2. Define image dimensions (e.g., 512x512 pixels for high quality)
      final ui.Image image = await painter.toImage(512);

      // 3. Convert image to byte data (PNG format)
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) return null;

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      // 4. Save to temporary directory file
      final Directory directory = await getTemporaryDirectory();
      final File file = File('${directory.path}/qr_ticket_$ticketId.png');
      await file.writeAsBytes(pngBytes);

      return file;
    } catch (e) {
      print('Background QR Generation Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ticket Details - ${widget.eventRefId}',
        ),
      ),

      body: RefreshIndicator(
        onRefresh: getTicketDatas,

        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )

            : errorMessage != null
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: getTicketDatas,
                child: const Text('Retry'),
              ),
            ],
          ),
        )

            : ListView(
          padding: const EdgeInsets.all(16),
          children: [

            // Summary
            Row(
              children: [
                Expanded(
                  child: _countCard(
                    'Total',
                    totalCount,
                    Colors.blue,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _countCard(
                    'Verified',
                    verifiedCount,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _countCard(
                    'Unverified',
                    unverifiedCount,
                    Colors.orange,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _countCard(
                    'Shared',
                    sharedCount,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            _countCard(
              'Not Shared',
              notSharedCount,
              Colors.red,
            ),

            const SizedBox(height: 20),

            const Text(
              'Tickets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...tickets.map(
                  (ticket) => _ticketCard(ticket),
            ),
          ],
        ),
      ),
    );
  }

  Widget _countCard(
      String title,
      int count,
      Color color,
      ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              count.toString(),
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketCard(dynamic ticket) {
    final bool verified = ticket['verified'].toString() == '1';
    final bool shared = ticket['shared'].toString() == '1';
    final String ticketId = ticket['id'].toString();

    String shared_to=ticket['full_name'].toString()+"\n"+
        ticket['mobile'].toString()+"\n"+ticket['reg_code']
    ;


    String qrstring =
    ticket['event_ref_id'].toString()+":"+ticket['id'].toString();

    // 1. Get or create the GlobalKey for this specific ticket ID
    final GlobalKey ticketKey = qrKeys.putIfAbsent(
      ticketId,
          () => GlobalKey(),
    );

    // 2. Wrap your card layout inside a RepaintBoundary
    return RepaintBoundary(
      key: ticketKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  (!shared)?   QrImageView(
                    data: qrstring,
                    version: QrVersions.auto,
                    size: 150,
                    backgroundColor: Colors.white,
                  ):Text("Shared To :  \n"+shared_to,style: TextStyle(fontSize: 12,color: Colors.teal),),

                  Container(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#MY_SAVE_${ticket['id']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      _buildStatusBadge(
                        label: verified ? 'Verified' : 'Not Verified',
                        isSuccess: verified,
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),
                  Row(
                    children: [
                      const Icon(Icons.receipt_long_outlined, size: 18, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Ref: ${ticket['event_ref_id']}',
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: shared
                        ? Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, size: 16, color: Colors.green),
                          SizedBox(width: 6),
                          Text(
                            'Ticket Shared',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ElevatedButton.icon(
                      onPressed: () async {



                        final selectedItem = await showDialog(
                          context: context,
                          builder: (context) => SearchListDialog(),
                        );

                        if (selectedItem != null) {

                          UserdataData usr=selectedItem as UserdataData;
                          String userid_to_share=usr.id.toString();

                          WidgetsBinding.instance.addPostFrameCallback((_) {

                            ResponsiveInfo.showLoaderDialog(context);
                          });

                          String? token= await AppStorage.getString(AppStorage.token);
                          final timestamp =
                              DateTime.now().millisecondsSinceEpoch ~/ 1000;



                          final res = await SavekartApiService.post(
                            Apimethodes.updateShareStatus+"?q="+timestamp.toString(),
                            token: token,
                            body: {
                              'shared': "1",
                              'user_id':userid_to_share,
                              'id':ticket['id'].toString(),
                              'timestamp':timestamp.toString()

                            },
                          );

                          print(res);
                          Navigator.pop(context);


                          bool status = res['data']['status'];
                          String message = res['data']['message'];

                          if (status) {
                            //print(message);

                            setState(() {
                              ticket['shared']=1;
                            });

                            ResponsiveInfo.showAlertDialog(context, "SAVEKART", message);
                            // Ticket shared successfully
                          } else {
                           // print(message);

                            ResponsiveInfo.showAlertDialog(context, "SAVEKART", "Ticket sharing failed");
                          }


                        }



                        // final File? qrFile = await generateQrFileFromString(ticket['event_ref_id']+":"+ticket['id'],ticketId);
                        //
                        // if (qrFile == null) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text('Failed to generate QR image'),
                        //     ),
                        //   );
                        //   return;
                        // }
                        //
                        // await Share.shareXFiles(
                        //   [XFile(qrFile.path)],
                        //   text: 'SaveApp Ticket\n\n'
                        //       'Ticket ID: $ticketId\n'
                        //       'Event Ref ID: ${ticket['event_ref_id']}',
                        // );



                      },
                      icon: const Icon(Icons.share_outlined, size: 16),
                      label: const Text('Share Ticket'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge({required String label, required bool isSuccess}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSuccess ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuccess ? Icons.check : Icons.close,
            size: 12,
            color: isSuccess ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}