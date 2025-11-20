// lib/features/project_updates/domain/repositories/project_updates_repository.dart

import '../../data/models/create_project_update_dto.dart';
import '../../data/models/project_update_dto.dart';

abstract class ProjectUpdatesRepository {
  Future<void> createProjectUpdate(CreateProjectUpdateDto dto);
  Future<void> updateProjectUpdate(String updateId, CreateProjectUpdateDto dto);
  Future<List<ProjectUpdateDto>> getAllProjectUpdates();
  Future<List<ProjectUpdateDto>> getUpdatesByProject(String projectId);
  Future<ProjectUpdateDto> getProjectUpdateById(String updateId);
  Future<void> deleteProjectUpdate(String updateId);
}
