// lib/features/project_updates/data/sources/project_updates_remote_source.dart

import 'package:dio/dio.dart';
import '../models/create_project_update_dto.dart';
import '../models/project_update_dto.dart';

class ProjectUpdatesRemoteSource {
  final Dio dio;

  ProjectUpdatesRemoteSource(this.dio);

  // Create Project Update
  Future<void> createProjectUpdate(CreateProjectUpdateDto dto) async {
    await dio.post('/project-updates', data: dto.toJson());
  }

  // Update Project Update
  Future<void> updateProjectUpdate(String updateId, CreateProjectUpdateDto dto) async {
    await dio.put('/project-updates/$updateId', data: dto.toJson());
  }

  // Get all Project Updates
  Future<List<ProjectUpdateDto>> getAllProjectUpdates() async {
    final response = await dio.get('/project-updates');
    return (response.data as List)
        .map((e) => ProjectUpdateDto.fromJson(e))
        .toList();
  }

  // Get Updates by Project
  Future<List<ProjectUpdateDto>> getUpdatesByProject(String projectId) async {
    final response = await dio.get('/projects/$projectId/updates');
    return (response.data as List)
        .map((e) => ProjectUpdateDto.fromJson(e))
        .toList();
  }

  // Get Project Update by ID
  Future<ProjectUpdateDto> getProjectUpdateById(String updateId) async {
    final response = await dio.get('/project-updates/$updateId');
    return ProjectUpdateDto.fromJson(response.data);
  }

  // Delete Project Update
  Future<void> deleteProjectUpdate(String updateId) async {
    await dio.delete('/project-updates/$updateId');
  }
}
