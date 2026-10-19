import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../design/ResponsiveInfo.dart';
import '../web/AppStorage.dart';
import '../web/SavekartApiHelper.dart';
import '../web/apimethodes.dart';

class GetFullTickets extends StatefulWidget {
  const GetFullTickets({super.key});

  @override
  State<GetFullTickets> createState() => _GetFullTicketsState();
}

class _GetFullTicketsState extends State<GetFullTickets> {
  bool isLoading = true;
  String errorMessage = '';

  List<FullTicketEntity> tickets = [];

  @override
  void initState() {
    super.initState();
    getEventBookingDetails();
  }

  Future<void> getEventBookingDetails() async {


    try {


      String idTransaction="0";
      final timestamp =
          DateTime.now().millisecondsSinceEpoch ~/ 1000;

      String? token= await AppStorage.getString(AppStorage.token);

      final res = await SavekartApiService.post(
        "fetchFullData?timestamp="+timestamp.toString(),
        token: token,
        body: {
          'event_id': "5"
        },
      );



      print('Status Code: ${res.statusCode}');
      print('Response: ${res.body}');

      if (res.statusCode == 200) {
        final Map<String, dynamic> responseData =
        jsonDecode(res.body);

        if (responseData['status'] == 'true') {
          final List data = responseData['data'] ?? [];

          setState(() {
            tickets = data
                .map(
                  (item) => FullTicketEntity.fromJson(item),
            )
                .toList();

            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage =
                responseData['message'] ?? 'Something went wrong';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage =
          'Server Error: ${res.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Tickets'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : errorMessage.isNotEmpty
          ? Center(
        child: Text(errorMessage),
      )
          : tickets.isEmpty
          ? const Center(
        child: Text('No tickets found'),
      )
          : RefreshIndicator(
        onRefresh: getEventBookingDetails,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            final ticket = tickets[index];

            return Card(
              margin: const EdgeInsets.only(
                bottom: 12,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ticket #${ticket.ticketId}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _verifiedStatus(
                          ticket.verified,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      ticket.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(ticket.mobile),
                    Text(ticket.email),

                    const Divider(),

                    _infoRow(
                      'Quantity',
                      ticket.qty,
                    ),

                    _infoRow(
                      'Payment Date',
                      ticket.paymentDate,
                    ),

                    _infoRow(
                      'Event Ref ID',
                      ticket.eventRefId,
                    ),

                    if (ticket.verified == '1')
                      _infoRow(
                        'Verified Date',
                        ticket.verifiedDate,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _verifiedStatus(String verified) {
    if (verified == '1') {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 18,
            ),
            SizedBox(width: 4),
            Text(
              'Verified',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.pending,
            color: Colors.orange,
            size: 18,
          ),
          SizedBox(width: 4),
          Text(
            'Not Verified',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class FullTicketEntity {
  final String id;
  final String eventId;
  final String name;
  final String mobile;
  final String email;
  final String paymentType;
  final String paymentDate;
  final String qty;
  final String paymentStatus;
  final String ticketId;
  final String eventRefId;
  final String verified;
  final String verifiedDate;

  FullTicketEntity({
    required this.id,
    required this.eventId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.paymentType,
    required this.paymentDate,
    required this.qty,
    required this.paymentStatus,
    required this.ticketId,
    required this.eventRefId,
    required this.verified,
    required this.verifiedDate,
  });

  factory FullTicketEntity.fromJson(Map<String, dynamic> json) {
    return FullTicketEntity(
      id: json['id'] ?? '',
      eventId: json['event_id'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      paymentType: json['payment_type'] ?? '',
      paymentDate: json['payment_date'] ?? '',
      qty: json['qty'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      ticketId: json['ticketid'] ?? '',
      eventRefId: json['event_ref_id'] ?? '',
      verified: json['verified'] ?? '',
      verifiedDate: json['verified_date'] ?? '',
    );
  }
}