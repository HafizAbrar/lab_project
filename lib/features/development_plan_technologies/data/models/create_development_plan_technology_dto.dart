class CreateDevelopmentPlanTechnologyDto {
  final String developmentPlanId;
  final String technologyId;

  CreateDevelopmentPlanTechnologyDto({
    required this.developmentPlanId,
    required this.technologyId,
  });

  Map<String, dynamic> toJson() {
    return {
      'developmentPlanId': developmentPlanId,
      'technologyId': technologyId,
    };
  }
}
