import '../../data/models/role_dto.dart';
import '../../data/models/create_role_dto.dart';
import '../../data/models/update_role_dto.dart';

abstract class RolesRepository {
  Future<List<RoleDto>> getRoles();
  Future<RoleDto> createRole(CreateRoleDto dto);
  Future<RoleDto> updateRole(String roleId, UpdateRoleDto dto);
  Future<void> deleteRole(String roleId);
}
