import '../../data/models/create_project_technology_dto.dart';
import '../../data/models/project_technology_dto.dart';

abstract class ProjectTechnologiesRepository {
  Future<void> createProjectTechnology(CreateProjectTechnologyDto dto);
  Future<void> updateProjectTechnology(String id, CreateProjectTechnologyDto dto);
  Future<void> deleteProjectTechnology(String id);
  Future<List<ProjectTechnologyDto>> getTechnologiesByProjectId(String projectId);
  Future<ProjectTechnologyDto> getProjectTechnologyById(String id);
}
