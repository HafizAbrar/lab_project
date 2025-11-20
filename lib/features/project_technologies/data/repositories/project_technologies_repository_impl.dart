import '../../domain/repositories/project_technologies_repository.dart';
import '../models/create_project_technology_dto.dart';
import '../models/project_technology_dto.dart';
import '../sources/project_technology_remote_source.dart';

class ProjectTechnologiesRepositoryImpl implements ProjectTechnologiesRepository {
  final ProjectTechnologyRemoteSource remoteSource;

  ProjectTechnologiesRepositoryImpl(this.remoteSource);

  @override
  Future<void> createProjectTechnology(CreateProjectTechnologyDto dto) {
    return remoteSource.createProjectTechnology(dto);
  }

  @override
  Future<void> updateProjectTechnology(String id, CreateProjectTechnologyDto dto) {
    return remoteSource.updateProjectTechnology(id, dto);
  }

  @override
  Future<void> deleteProjectTechnology(String id) {
    return remoteSource.deleteProjectTechnology(id);
  }

  @override
  Future<List<ProjectTechnologyDto>> getTechnologiesByProjectId(String projectId) {
    return remoteSource.getTechnologiesByProjectId(projectId);
  }

  @override
  Future<ProjectTechnologyDto> getProjectTechnologyById(String id) {
    return remoteSource.getProjectTechnologyById(id);
  }
}
