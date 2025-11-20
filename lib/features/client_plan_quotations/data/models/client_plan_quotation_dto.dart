class ClientPlanQuotationDto {
  final String id;
  final String clientPlanId;
  final double quotationAmount;
  final String currency;
  final String remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClientPlanQuotationDto({
    required this.id,
    required this.clientPlanId,
    required this.quotationAmount,
    required this.currency,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClientPlanQuotationDto.fromJson(Map<String, dynamic> json) {
    return ClientPlanQuotationDto(
      id: json['id'],
      clientPlanId: json['clientPlanId'],
      quotationAmount: (json['quotationAmount'] as num).toDouble(),
      currency: json['currency'],
      remarks: json['remarks'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientPlanId': clientPlanId,
      'quotationAmount': quotationAmount,
      'currency': currency,
      'remarks': remarks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
