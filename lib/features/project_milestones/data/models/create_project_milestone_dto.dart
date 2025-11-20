// lib/features/project_milestones/data/models/create_project_milestone_dto.dart

class CreateProjectMilestoneDto {
  final String projectId;     // FK to Project
  final String title;
  final String description;
  final String dueDate;       // ISO date string, e.g., "2025-10-15"
  final String? status;       // optional: "pending", "in-progress", "completed"

  CreateProjectMilestoneDto({
    required this.projectId,
    required this.title,
    required this.description,
    required this.dueDate,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      if (status != null) 'status': status,
    };
  }
}
