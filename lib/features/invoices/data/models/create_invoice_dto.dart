class CreateInvoiceDto {
  final String clientId;
  final String projectId;
  final double amount;
  final String currency;
  final String status; // e.g., "Pending", "Paid"
  final String? notes;

  CreateInvoiceDto({
    required this.clientId,
    required this.projectId,
    required this.amount,
    required this.currency,
    required this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'projectId': projectId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'notes': notes,
    };
  }
}
