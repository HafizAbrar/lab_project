// lib/features/project_updates/data/models/create_project_update_dto.dart

class CreateProjectUpdateDto {
  final String projectId;   // Reference to Project
  final String title;
  final String description;
  final String updateDate;  // e.g. "2025-10-12"
  final String? status;     // optional: "on-track", "delayed", "completed"

  CreateProjectUpdateDto({
    required this.projectId,
    required this.title,
    required this.description,
    required this.updateDate,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'title': title,
      'description': description,
      'updateDate': updateDate,
      if (status != null) 'status': status,
    };
  }
}
