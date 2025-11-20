class CreateDevelopmentPlanFeatureDto {
  final String developmentPlanId;
  final String name;
  final String description;
  final bool isActive;

  CreateDevelopmentPlanFeatureDto({
    required this.developmentPlanId,
    required this.name,
    required this.description,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    'developmentPlanId': developmentPlanId,
    'name': name,
    'description': description,
    'isActive': isActive,
  };
}
