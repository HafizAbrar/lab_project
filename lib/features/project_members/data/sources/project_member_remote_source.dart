import 'package:dio/dio.dart';
import '../models/create_project_member_dto.dart';
import '../models/project_member_dto.dart';

class ProjectMemberRemoteSource {
  final Dio dio;

  ProjectMemberRemoteSource(this.dio);

  Future<void> createProjectMember(CreateProjectMemberDto dto) async {
    await dio.post('/project_members', data: dto.toJson());
  }

  Future<void> updateProjectMember(String memberId, CreateProjectMemberDto dto) async {
    await dio.put('/project_members/$memberId', data: dto.toJson());
  }

  Future<void> deleteProjectMember(String memberId) async {
    await dio.delete('/project_members/$memberId');
  }

  Future<List<ProjectMemberDto>> getMembersByProjectId(String projectId) async {
    final response = await dio.get('/project_members/project/$projectId');
    final data = response.data as List;
    return data.map((e) => ProjectMemberDto.fromJson(e)).toList();
  }

  Future<ProjectMemberDto> getProjectMemberById(String id) async {
    final response = await dio.get('/project_members/$id');
    return ProjectMemberDto.fromJson(response.data);
  }
}
