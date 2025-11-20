class InvoiceDto {
  final String id;
  final String clientId;
  final String projectId;
  final double amount;
  final String currency;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  InvoiceDto({
    required this.id,
    required this.clientId,
    required this.projectId,
    required this.amount,
    required this.currency,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvoiceDto.fromJson(Map<String, dynamic> json) {
    return InvoiceDto(
      id: json['id'],
      clientId: json['clientId'],
      projectId: json['projectId'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'projectId': projectId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
