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