// lib/features/projects/data/sources/projects_remote_source.dart
import 'package:dio/dio.dart';
import '../models/create_project_dto.dart';
import '../models/project_dto.dart';

class ProjectsRemoteSource {
  final Dio dio;

  ProjectsRemoteSource(this.dio);

  /// CREATE PROJECT
  Future<ProjectDto> createProject(CreateProjectDto dto) async {
    try {
      final formData = await dto.toFormData();

      final response = await dio.post(
        '/projects',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      // Many backends wrap result in { data: {...} } — handle both shapes.
      final responseData = response.data is Map && response.data.containsKey('data')
          ? response.data['data']
          : response.data;

      return ProjectDto.fromJson(responseData);
    } catch (e) {
      print('❌ Error creating project: $e');
      rethrow;
    }
  }

  /// GET ALL PROJECTS
  Future<List<ProjectDto>> getAllProjects() async {
    try {
      final response = await dio.get('/projects');

      final data = response.data is List
          ? response.data
          : response.data['data'] ?? [];

      return (data as List).map((e) => ProjectDto.fromJson(e)).toList();
    } catch (e) {
      print('❌ Error fetching projects: $e');
      rethrow;
    }
  }

  /// UPDATE PROJECT
  Future<ProjectDto> updateProject(String id, CreateProjectDto dto) async {
    try {
      final formData = await dto.toFormData();

      final response = await dio.patch(
        '/projects/$id',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final responseData = response.data is Map && response.data.containsKey('data')
          ? response.data['data']
          : response.data;

      return ProjectDto.fromJson(responseData);
    } catch (e) {
      print('❌ Error updating project: $e');
      rethrow;
    }
  }

  /// DELETE PROJECT
  Future<void> deleteProject(String id) async {
    try {
      await dio.delete('/projects/$id');
    } catch (e) {
      print('❌ Error deleting project: $e');
      rethrow;
    }
  }
}
