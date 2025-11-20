// lib/features/project_updates/data/repositories/project_updates_repository_impl.dart


import '../../domain/repositories/project_updates_repository.dart';
import '../sources/project_updates_remote_source.dart';
import '../models/create_project_update_dto.dart';
import '../models/project_update_dto.dart';

class ProjectUpdatesRepositoryImpl implements ProjectUpdatesRepository {
  final ProjectUpdatesRemoteSource remoteSource;

  ProjectUpdatesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createProjectUpdate(CreateProjectUpdateDto dto) {
    return remoteSource.createProjectUpdate(dto);
  }

  @override
  Future<void> updateProjectUpdate(String updateId, CreateProjectUpdateDto dto) {
    return remoteSource.updateProjectUpdate(updateId, dto);
  }

  @override
  Future<List<ProjectUpdateDto>> getAllProjectUpdates() {
    return remoteSource.getAllProjectUpdates();
  }

  @override
  Future<List<ProjectUpdateDto>> getUpdatesByProject(String projectId) {
    return remoteSource.getUpdatesByProject(projectId);
  }

  @override
  Future<ProjectUpdateDto> getProjectUpdateById(String updateId) {
    return remoteSource.getProjectUpdateById(updateId);
  }

  @override
  Future<void> deleteProjectUpdate(String updateId) {
    return remoteSource.deleteProjectUpdate(updateId);
  }
}
