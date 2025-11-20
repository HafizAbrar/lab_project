import '../../domain/repositories/projects_repository.dart';
import '../models/create_project_dto.dart';
import '../models/project_dto.dart';
import '../sources/projects_remote_source.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsRemoteSource remoteSource;

  ProjectsRepositoryImpl(this.remoteSource);

  @override
  Future<ProjectDto> createProject(CreateProjectDto dto) async {
    final result = await remoteSource.createProject(dto);
    if (result == null) throw Exception('Failed to create project');
    return result;
  }

  @override
  Future<ProjectDto> updateProject(String projectId, CreateProjectDto dto) async {
    final result = await remoteSource.updateProject(projectId, dto);
    if (result == null) throw Exception('Failed to update project');
    return result;
  }

  @override
  Future<List<ProjectDto>> getAllProjects() {
    return remoteSource.getAllProjects();
  }

  @override
  Future<void> deleteProject(String projectId) {
    return remoteSource.deleteProject(projectId);
  }
}
