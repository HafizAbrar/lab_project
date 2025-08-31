import 'package:lab_app/features/users/data/models/create_user_dto.dart';
import 'package:lab_app/features/users/data/models/user_dto.dart';
import 'package:lab_app/features/users/data/sources/users_remote_source.dart';
import 'package:lab_app/features/users/domain/repositories/users_repository.dart';

import '../../../permissions/data/modals/permission_dto.dart';
import '../models/createUserWithPermission_dto.dart';
import '../models/feature_dto.dart';
import '../models/updatePermissions_dto.dart';
import '../models/update_user_dto.dart';
import '../models/user_permissions_dto.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this._remote);
  final UsersRemoteSource _remote;

  @override
  Future<List<UserDto>> findAll() => _remote.findAll();

  @override
  Future<UserPermissionsDto> getUserPermissions(String userId) =>
      _remote.getUserPermissions(userId);

  @override
  Future<UserDto> createUser(CreateUserDto dto) => _remote.createUser(dto);

  @override
  Future<UserDto> createUserWithPermissions(CreateUserWithPermissionsDto dto) =>
      _remote.createUserWithPermissions(dto); // ✅ forward to remote

  @override
  Future<List<PermissionDto>> getAllPermissions() => _remote.getAllPermissions();

  @override
  Future<void> assignPermissions(String userId, UpdatePermissionDto dto) {
    return _remote.assignPermissions(userId, dto);
  }

  @override
  Future<void> updatePermissions(String userId, UpdatePermissionDto dto) {
    return _remote.updateUserPermissions(userId, dto);
  }
  @override
  Future<void> deleteUser(String userId) => _remote.deleteUser(userId);

  @override
  Future<List<FeatureDto>> getAllFeatures() => _remote.getAllFeatures();

  @override
  Future<UserDto> updateUser(String userId, UpdateUserDto dto) =>
      _remote.updateUser(userId, dto);
}
