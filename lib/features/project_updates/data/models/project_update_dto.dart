// lib/features/project_updates/data/models/project_update_dto.dart

class ProjectUpdateDto {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final String updateDate;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectUpdateDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.updateDate,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectUpdateDto.fromJson(Map<String, dynamic> json) {
    return ProjectUpdateDto(
      id: json['id'].toString(),
      projectId: json['projectId'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      updateDate: json['updateDate'] ?? '',
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'updateDate': updateDate,
      if (status != null) 'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
