// lib/features/project_milestones/data/sources/project_milestones_remote_source.dart

import 'package:dio/dio.dart';
import '../models/create_project_milestone_dto.dart';
import '../models/project_milestone_dto.dart';

class ProjectMilestonesRemoteSource {
  final Dio dio;

  ProjectMilestonesRemoteSource(this.dio);

  // Create Milestone
  Future<void> createProjectMilestone(CreateProjectMilestoneDto dto) async {
    await dio.post('/project-milestones', data: dto.toJson());
  }

  // Update Milestone
  Future<void> updateProjectMilestone(String milestoneId, CreateProjectMilestoneDto dto) async {
    await dio.put('/project-milestones/$milestoneId', data: dto.toJson());
  }

  // Get all Milestones
  Future<List<ProjectMilestoneDto>> getAllProjectMilestones() async {
    final response = await dio.get('/project-milestones');
    return (response.data as List)
        .map((e) => ProjectMilestoneDto.fromJson(e))
        .toList();
  }

  // Get Milestones of a specific Project
  Future<List<ProjectMilestoneDto>> getMilestonesByProject(String projectId) async {
    final response = await dio.get('/projects/$projectId/milestones');
    return (response.data as List)
        .map((e) => ProjectMilestoneDto.fromJson(e))
        .toList();
  }

  // Get Milestone by ID
  Future<ProjectMilestoneDto> getProjectMilestoneById(String milestoneId) async {
    final response = await dio.get('/project-milestones/$milestoneId');
    return ProjectMilestoneDto.fromJson(response.data);
  }

  // Delete Milestone
  Future<void> deleteProjectMilestone(String milestoneId) async {
    await dio.delete('/project-milestones/$milestoneId');
  }
}
