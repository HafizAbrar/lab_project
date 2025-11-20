class InvoiceItemDto {
  final String id;
  final String invoiceId;
  final String description;
  final int quantity;
  final double unitPrice;
  final double total;

  InvoiceItemDto({
    required this.id,
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  factory InvoiceItemDto.fromJson(Map<String, dynamic> json) {
    return InvoiceItemDto(
      id: json['id'],
      invoiceId: json['invoiceId'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'invoiceId': invoiceId,
    'description': description,
    'quantity': quantity,
    'unitPrice': unitPrice,
    'total': total,
  };
}
