import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:savekart/web/encrypthelper.dart';
import '../web/AppStorage.dart';

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
    final bool verified =
        ticket['verified'].toString() == '1';

    final bool shared =
        ticket['shared'].toString() == '1';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            QrImageView(
              data:  EncryptionHelper.encryptText(widget.eventRefId.toString()+":"+ticket['id'].toString()),
              version: QrVersions.auto,
              size: 125,
            ),

            Text(
              'Ticket ID: ${ticket['id']}',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Event ID: ${ticket['event_id']}',
            ),

            Text(
              'Event Ref ID: ${ticket['event_ref_id']}',
            ),

            const SizedBox(height: 8),

            Row(
              children: [

                Expanded(
                  child: Text(
                    verified
                        ? '✓ Verified'
                        : '✗ Not Verified',

                    style: TextStyle(
                      color: verified
                          ? Colors.green
                          : Colors.red,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: shared? Text(

                         '✓ Shared',


                    style: TextStyle(
                      color: Colors.green,


                      fontWeight: FontWeight.bold,
                    ),
                  ) :
                  TextButton(onPressed: (){

                  }, child: Text("Share Ticket")),
                ),
              ],
            ),

            if (ticket['verified_date'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Verified Date: ${ticket['verified_date']}',
                ),
              ),
          ],
        ),
      ),
    );
  }
}