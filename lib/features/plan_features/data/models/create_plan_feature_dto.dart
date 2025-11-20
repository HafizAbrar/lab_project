class CreatePlanFeatureDto {
  final String name;
  final String description;
  final bool isActive;

  CreatePlanFeatureDto({
    required this.name,
    required this.description,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'isActive': isActive,
  };
}
