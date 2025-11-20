import '../../domain/repositories/project_members_repository.dart';
import '../models/create_project_member_dto.dart';
import '../models/project_member_dto.dart';
import '../sources/project_member_remote_source.dart';

class ProjectMembersRepositoryImpl implements ProjectMembersRepository {
  final ProjectMemberRemoteSource remoteSource;

  ProjectMembersRepositoryImpl(this.remoteSource);

  @override
  Future<void> createProjectMember(CreateProjectMemberDto dto) {
    return remoteSource.createProjectMember(dto);
  }

  @override
  Future<void> updateProjectMember(String memberId, CreateProjectMemberDto dto) {
    return remoteSource.updateProjectMember(memberId, dto);
  }

  @override
  Future<void> deleteProjectMember(String memberId) {
    return remoteSource.deleteProjectMember(memberId);
  }

  @override
  Future<List<ProjectMemberDto>> getMembersByProjectId(String projectId) {
    return remoteSource.getMembersByProjectId(projectId);
  }

  @override
  Future<ProjectMemberDto> getProjectMemberById(String id) {
    return remoteSource.getProjectMemberById(id);
  }
}
