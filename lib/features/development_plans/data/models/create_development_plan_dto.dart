class CreateDevelopmentPlanDto {
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  CreateDevelopmentPlanDto({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
  };
}
