import '../../../permissions/data/modals/permission_dto.dart';
import '../../../users/data/models/create_user_dto.dart';
import '../../../users/data/models/user_dto.dart';
import '../../data/models/createUserWithPermission_dto.dart';
import '../../data/models/feature_dto.dart';
import '../../data/models/updatePermissions_dto.dart';
import '../../data/models/update_user_dto.dart';
import '../../data/models/user_permissions_dto.dart';

abstract interface class UsersRepository {
  Future<List<UserDto>> findAll();
  Future<UserDto> createUser(CreateUserDto dto);
  Future<UserDto> createUserWithPermissions(CreateUserWithPermissionsDto dto);
  Future<void> deleteUser(String userId);
  Future<UserDto> updateUser(String userId, UpdateUserDto dto);
  Future<UserPermissionsDto> getUserPermissions(String userId);
  Future<List<PermissionDto>> getAllPermissions();
  Future<List<FeatureDto>> getAllFeatures();
  // 🔄 change to use UpdatePermissionDto
  Future<void> assignPermissions(String userId, UpdatePermissionDto dto);

  Future<void> updatePermissions(String userId, UpdatePermissionDto dto);
}



