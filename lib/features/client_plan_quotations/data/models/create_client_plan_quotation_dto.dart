class CreateClientPlanQuotationDto {
  final String clientPlanId;
  final double quotationAmount;
  final String currency;
  final String remarks;

  CreateClientPlanQuotationDto({
    required this.clientPlanId,
    required this.quotationAmount,
    required this.currency,
    required this.remarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'clientPlanId': clientPlanId,
      'quotationAmount': quotationAmount,
      'currency': currency,
      'remarks': remarks,
    };
  }
}
