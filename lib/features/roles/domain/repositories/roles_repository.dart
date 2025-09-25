import '../../../permissions/data/modals/permission_dto.dart';
import '../../data/models/role_dto.dart';
import '../../data/models/create_role_dto.dart';
import '../../data/models/update_role_dto.dart';

abstract class RolesRepository {
  Future<List<RoleDto>> getRoles();
  Future<RoleDto> createRole(CreateRoleDto dto);
  Future<RoleDto> updateRole(String roleId, UpdateRoleDto dto);
  Future<void> deleteRole(String roleId);
  Future<void> updateRolePermissions(String roleId, List<String> permissionIds);

  /// new method
  Future<List<PermissionDto>> getRolePermissions(String roleId);
}
