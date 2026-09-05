import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../web/AppStorage.dart';
import 'full_tickets.dart';

class EventTicketsPage extends StatefulWidget {
  final String eventId;
  final String mobile;

  EventTicketsPage({
    super.key,
    required this.eventId,
    required this.mobile,
  });

  @override
  State<EventTicketsPage> createState() => _EventTicketsPageState();
}

class _EventTicketsPageState extends State<EventTicketsPage> {
  bool isLoading = false;
  String errorMessage = '';

  List<dynamic> tickets = [];

  @override
  void initState() {
    super.initState();
    getEventTickets();
  }

  Future<void> getEventTickets() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      String? token = await AppStorage.getString(AppStorage.token);

      final url = Uri.parse(
        'https://mysaving.in/SavekartApi/getEventTicket',
      );

      final response = await http.post(
        url,
        headers: {
          'Authorization': token.toString() + '|' + timestamp.toString(),
          'timestamp': timestamp.toString(),
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'eventId': widget.eventId,
          'mobile': widget.mobile,
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'].toString() == 'true') {
          setState(() {
            tickets = responseData['data'] ?? [];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = responseData['message'] ?? 'No tickets found';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Something went wrong: $e';
        isLoading = false;
      });

      print('API Error: $e');
    }
  }

  String getPaymentStatus(String status) {
    switch (status) {
      case '1':
        return 'Paid';
      case '0':
        return 'Pending';
      default:
        return 'Unknown';
    }
  }

  Color getPaymentStatusColor(String status) {
    switch (status) {
      case '1':
        return Colors.green;
      case '0':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Tickets'),
      ),
      body: RefreshIndicator(
        onRefresh: getEventTickets,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : errorMessage.isNotEmpty
                ? ListView(
                    children: [
                      const SizedBox(height: 150),
                      Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              errorMessage,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: getEventTickets,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : tickets.isEmpty
                    ? ListView(
                        children: const [
                          SizedBox(height: 200),
                          Center(
                            child: Text(
                              'No tickets found',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];

                          final paymentStatus =
                              ticket['payment_status']?.toString() ?? '';

                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.confirmation_number,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          'Ticket #${ticket['id']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: getPaymentStatusColor(
                                            paymentStatus,
                                          ).withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          getPaymentStatus(
                                            paymentStatus,
                                          ),
                                          style: TextStyle(
                                            color: getPaymentStatusColor(
                                              paymentStatus,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 25),
                                  _ticketRow(
                                    Icons.person,
                                    'Name',
                                    ticket['name'],
                                  ),
                                  _ticketRow(
                                    Icons.phone,
                                    'Mobile',
                                    ticket['mobile'],
                                  ),
                                  _ticketRow(
                                    Icons.email,
                                    'Email',
                                    ticket['email'],
                                  ),
                                  _ticketRow(
                                    Icons.confirmation_number,
                                    'Quantity',
                                    ticket['qty'],
                                  ),
                                  _ticketRow(
                                    Icons.calendar_today,
                                    'Payment Date',
                                    ticket['payment_date'],
                                  ),
                                 
                                 Padding(padding: EdgeInsets.all(10),
                                 
                                 child: TextButton(onPressed: (){

                                  Navigator.push(
                                   context,
                                   MaterialPageRoute(builder: (context) => TicketDetailsPage( eventRefId: ticket['id'],)),
                                  );


                                 }, child: Text("View Details")),
                                 
                                 )
                                 
                                ],
                              ),
                            ),
                          );
                        },
                      ),
      ),
    );
  }

  Widget _ticketRow(
    IconData icon,
    String title,
    dynamic value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? '',
            ),
          ),
        ],
      ),
    );
  }
}
