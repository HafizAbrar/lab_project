class DevelopmentPlanServiceDto {
  final String id;
  final String developmentPlanId;
  final String serviceId;
  final DateTime createdAt;
  final DateTime updatedAt;

  DevelopmentPlanServiceDto({
    required this.id,
    required this.developmentPlanId,
    required this.serviceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DevelopmentPlanServiceDto.fromJson(Map<String, dynamic> json) {
    return DevelopmentPlanServiceDto(
      id: json['id'],
      developmentPlanId: json['developmentPlanId'],
      serviceId: json['serviceId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'developmentPlanId': developmentPlanId,
      'serviceId': serviceId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
