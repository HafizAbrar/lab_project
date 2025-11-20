import '../../data/models/create_project_member_dto.dart';
import '../../data/models/project_member_dto.dart';

abstract class ProjectMembersRepository {
  Future<void> createProjectMember(CreateProjectMemberDto dto);
  Future<void> updateProjectMember(String memberId, CreateProjectMemberDto dto);
  Future<void> deleteProjectMember(String memberId);
  Future<List<ProjectMemberDto>> getMembersByProjectId(String projectId);
  Future<ProjectMemberDto> getProjectMemberById(String id);
}
