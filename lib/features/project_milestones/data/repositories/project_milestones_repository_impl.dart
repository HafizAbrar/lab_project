// lib/features/project_milestones/data/repositories/project_milestones_repository_impl.dart
import '../../domain/repositories/project_milestones_repository.dart';
import '../sources/project_milestones_remote_source.dart';
import '../models/create_project_milestone_dto.dart';
import '../models/project_milestone_dto.dart';

class ProjectMilestonesRepositoryImpl implements ProjectMilestonesRepository {
  final ProjectMilestonesRemoteSource remoteSource;

  ProjectMilestonesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createProjectMilestone(CreateProjectMilestoneDto dto) {
    return remoteSource.createProjectMilestone(dto);
  }

  @override
  Future<void> updateProjectMilestone(String milestoneId, CreateProjectMilestoneDto dto) {
    return remoteSource.updateProjectMilestone(milestoneId, dto);
  }

  @override
  Future<List<ProjectMilestoneDto>> getAllProjectMilestones() {
    return remoteSource.getAllProjectMilestones();
  }

  @override
  Future<List<ProjectMilestoneDto>> getMilestonesByProject(String projectId) {
    return remoteSource.getMilestonesByProject(projectId);
  }

  @override
  Future<ProjectMilestoneDto> getProjectMilestoneById(String milestoneId) {
    return remoteSource.getProjectMilestoneById(milestoneId);
  }

  @override
  Future<void> deleteProjectMilestone(String milestoneId) {
    return remoteSource.deleteProjectMilestone(milestoneId);
  }
}
