class DevelopmentPlanFeatureDto {
  final String id;
  final String developmentPlanId;
  final String name;
  final String description;
  final bool isActive;

  DevelopmentPlanFeatureDto({
    required this.id,
    required this.developmentPlanId,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory DevelopmentPlanFeatureDto.fromJson(Map<String, dynamic> json) {
    return DevelopmentPlanFeatureDto(
      id: json['_id'] ?? '',
      developmentPlanId: json['developmentPlanId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'developmentPlanId': developmentPlanId,
    'name': name,
    'description': description,
    'isActive': isActive,
  };
}
