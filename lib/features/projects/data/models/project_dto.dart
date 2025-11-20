// lib/features/projects/data/models/project_dto.dart

class ProjectDto {
  final String id;
  final String name;
  final String description;
  final String startDate;
  final String? endDate;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectDto({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectDto.fromJson(Map<String, dynamic> json) {
    return ProjectDto(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate,
      if (endDate != null) 'endDate': endDate,
      if (status != null) 'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
