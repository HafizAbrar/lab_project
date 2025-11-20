class DevelopmentPlanTechnologyDto {
  final String id;
  final String developmentPlanId;
  final String technologyId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DevelopmentPlanTechnologyDto({
    required this.id,
    required this.developmentPlanId,
    required this.technologyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DevelopmentPlanTechnologyDto.fromJson(Map<String, dynamic> json) {
    return DevelopmentPlanTechnologyDto(
      id: json['id'],
      developmentPlanId: json['developmentPlanId'],
      technologyId: json['technologyId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'developmentPlanId': developmentPlanId,
      'technologyId': technologyId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
