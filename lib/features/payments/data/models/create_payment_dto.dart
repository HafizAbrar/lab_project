class CreatePaymentDto {
  final String invoiceId;
  final String clientId;
  final double amount;
  final String currency;
  final String method;
  final String status; // initial status, e.g., "pending"
  final String? transactionId;
  final DateTime? paidAt;
  final String? notes;

  CreatePaymentDto({
    required this.invoiceId,
    required this.clientId,
    required this.amount,
    required this.currency,
    required this.method,
    required this.status,
    this.transactionId,
    this.paidAt,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'invoiceId': invoiceId,
      'clientId': clientId,
      'amount': amount,
      'currency': currency,
      'method': method,
      'status': status,
      'transactionId': transactionId,
      'paidAt': paidAt?.toIso8601String(),
      'notes': notes,
    };
  }
}
