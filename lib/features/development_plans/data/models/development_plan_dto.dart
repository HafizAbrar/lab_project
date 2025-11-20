class DevelopmentPlanDto {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  DevelopmentPlanDto({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  factory DevelopmentPlanDto.fromJson(Map<String, dynamic> json) {
    return DevelopmentPlanDto(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'description': description,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  };
}
