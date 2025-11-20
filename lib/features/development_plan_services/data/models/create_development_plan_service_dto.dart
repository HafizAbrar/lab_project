class CreateDevelopmentPlanServiceDto {
  final String developmentPlanId;
  final String serviceId;

  CreateDevelopmentPlanServiceDto({
    required this.developmentPlanId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'developmentPlanId': developmentPlanId,
      'serviceId': serviceId,
    };
  }
}
