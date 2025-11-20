class PaymentDto {
  final String id;
  final String invoiceId;
  final String clientId;
  final double amount;
  final String currency;
  final String method; // e.g., "bank_transfer", "card", "paypal"
  final String status; // e.g., "pending", "completed", "failed", "refunded"
  final String? transactionId;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? notes;

  PaymentDto({
    required this.id,
    required this.invoiceId,
    required this.clientId,
    required this.amount,
    required this.currency,
    required this.method,
    required this.status,
    this.transactionId,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  factory PaymentDto.fromJson(Map<String, dynamic> json) {
    return PaymentDto(
      id: json['id'] ?? json['_id'] ?? '',
      invoiceId: json['invoiceId'] ?? '',
      clientId: json['clientId'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      currency: json['currency'] ?? 'USD',
      method: json['method'] ?? '',
      status: json['status'] ?? '',
      transactionId: json['transactionId'],
      paidAt: json['paidAt'] != null ? DateTime.tryParse(json['paidAt']) : null,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'clientId': clientId,
      'amount': amount,
      'currency': currency,
      'method': method,
      'status': status,
      'transactionId': transactionId,
      'paidAt': paidAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'notes': notes,
    };
  }
}
