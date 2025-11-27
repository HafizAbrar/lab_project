class ProjectDto {
  final String id;
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final String status;
  final double budget;
  final List<String> images;
  final String? clientId;

  ProjectDto({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.budget,
    required this.images,
    this.clientId,
  });

  /// Safely parse budget from int, double, or string
  static double _parseBudget(dynamic value) {
    if (value == null) return 0.0;

    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0; // fallback
  }

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Untitled Project',
      description: json['description'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      status: json['status'] ?? '',
      budget: _parseBudget(json['budget']),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      clientId: json['clientId'],
    );
  }
}
