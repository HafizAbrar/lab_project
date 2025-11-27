// lib/features/projects/domain/repositories/projects_repository.dart
import '../../data/models/create_project_dto.dart';
import '../../data/models/project_dto.dart';

abstract class ProjectsRepository {
  Future<ProjectDto> createProject(CreateProjectDto dto);
  Future<ProjectDto> updateProject(String projectId, CreateProjectDto dto);
  Future<List<ProjectDto>> getAllProjects();
  Future<void> deleteProject(String projectId);
}
