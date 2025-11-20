class PlanFeatureDto {
  final String id;
  final String name;
  final String description;
  final bool isActive;

  PlanFeatureDto({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
  });

  factory PlanFeatureDto.fromJson(Map<String, dynamic> json) {
    return PlanFeatureDto(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'isActive': isActive,
  };
}
