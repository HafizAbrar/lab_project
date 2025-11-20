import 'package:dio/dio.dart';
import '../models/create_project_technology_dto.dart';
import '../models/project_technology_dto.dart';

class ProjectTechnologyRemoteSource {
  final Dio dio;

  ProjectTechnologyRemoteSource(this.dio);

  Future<void> createProjectTechnology(CreateProjectTechnologyDto dto) async {
    await dio.post('/project_technologies', data: dto.toJson());
  }

  Future<void> updateProjectTechnology(String id, CreateProjectTechnologyDto dto) async {
    await dio.put('/project_technologies/$id', data: dto.toJson());
  }

  Future<void> deleteProjectTechnology(String id) async {
    await dio.delete('/project_technologies/$id');
  }

  Future<List<ProjectTechnologyDto>> getTechnologiesByProjectId(String projectId) async {
    final response = await dio.get('/project_technologies/project/$projectId');
    final data = response.data as List;
    return data.map((e) => ProjectTechnologyDto.fromJson(e)).toList();
  }

  Future<ProjectTechnologyDto> getProjectTechnologyById(String id) async {
    final response = await dio.get('/project_technologies/$id');
    return ProjectTechnologyDto.fromJson(response.data);
  }
}
