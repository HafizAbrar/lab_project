class CreateInvoiceItemDto {
  final String invoiceId;
  final String description;
  final int quantity;
  final double unitPrice;

  CreateInvoiceItemDto({
    required this.invoiceId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  Map<String, dynamic> toJson() => {
    'invoiceId': invoiceId,
    'description': description,
    'quantity': quantity,
    'unitPrice': unitPrice,
  };
}
