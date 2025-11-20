// lib/features/project_milestones/domain/repositories/project_milestones_repository.dart

import '../../data/models/create_project_milestone_dto.dart';
import '../../data/models/project_milestone_dto.dart';

abstract class ProjectMilestonesRepository {
  Future<void> createProjectMilestone(CreateProjectMilestoneDto dto);
  Future<void> updateProjectMilestone(String milestoneId, CreateProjectMilestoneDto dto);
  Future<List<ProjectMilestoneDto>> getAllProjectMilestones();
  Future<List<ProjectMilestoneDto>> getMilestonesByProject(String projectId);
  Future<ProjectMilestoneDto> getProjectMilestoneById(String milestoneId);
  Future<void> deleteProjectMilestone(String milestoneId);
}
