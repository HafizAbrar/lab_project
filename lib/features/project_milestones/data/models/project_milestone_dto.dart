// lib/features/project_milestones/data/models/project_milestone_dto.dart

class ProjectMilestoneDto {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final String dueDate;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectMilestoneDto({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProjectMilestoneDto.fromJson(Map<String, dynamic> json) {
    return ProjectMilestoneDto(
      id: json['id'].toString(),
      projectId: json['projectId'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      dueDate: json['dueDate'] ?? '',
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
      'dueDate': dueDate,
      if (status != null) 'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
