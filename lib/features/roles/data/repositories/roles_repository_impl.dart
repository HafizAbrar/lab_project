import '../../domain/repositories/roles_repository.dart';
import '../models/role_dto.dart';
import '../models/create_role_dto.dart';
import '../models/update_role_dto.dart';
import '../sources/roles_remote_source.dart';

class RolesRepositoryImpl implements RolesRepository {
  final RolesRemoteSource _remoteSource;

  RolesRepositoryImpl(this._remoteSource);

  @override
  Future<List<RoleDto>> getRoles() => _remoteSource.getRoles();

  @override
  Future<RoleDto> createRole(CreateRoleDto dto) => _remoteSource.createRole(dto);

  @override
  Future<RoleDto> updateRole(String roleId, UpdateRoleDto dto) =>
      _remoteSource.updateRole(roleId, dto);

  @override
  Future<void> deleteRole(String roleId) => _remoteSource.deleteRole(roleId);
}
