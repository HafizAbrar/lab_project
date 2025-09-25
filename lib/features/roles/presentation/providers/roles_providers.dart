import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lab_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';

import '../../../permissions/data/modals/permission_dto.dart';
import '../../../permissions/presentation/providers/permission_provider.dart';
import '../../data/models/role_dto.dart';
import '../../data/models/create_role_dto.dart';
import '../../data/models/update_role_dto.dart';
import '../../data/repositories/roles_repository_impl.dart';
import '../../data/sources/roles_remote_source.dart';
import '../../domain/repositories/roles_repository.dart';

// -----------------------
// Secure storage provider
// -----------------------
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

// -----------------------
// Dio provider using DioClient
// -----------------------
final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);
  final client = DioClient(storage);
  return client.build();
});

// -----------------------
// Remote source provider
// -----------------------
final rolesRemoteSourceProvider =
Provider((ref) => RolesRemoteSource(ref.read(dioProvider)));

// -----------------------
// Repository provider
// -----------------------
final rolesRepositoryProvider = Provider<RolesRepository>(
      (ref) => RolesRepositoryImpl(ref.read(rolesRemoteSourceProvider)),
);

// -----------------------
// Roles list provider
// -----------------------
final rolesListProvider = FutureProvider<List<RoleDto>>((ref) async {
  final repo = ref.read(rolesRepositoryProvider);
  return repo.getRoles();
});

// -----------------------
// Create Role provider
// -----------------------
final createRoleProvider =
FutureProvider.family<RoleDto, CreateRoleDto>((ref, dto) async {
  final repo = ref.read(rolesRepositoryProvider);
  return repo.createRole(dto);
});

// -----------------------
// Update Role provider
// -----------------------
final updateRoleProvider = FutureProvider.family<RoleDto, Map<String, dynamic>>(
        (ref, params) async {
      final repo = ref.read(rolesRepositoryProvider);
      final String roleId = params['roleId'];
      final UpdateRoleDto dto = params['dto'];
      return repo.updateRole(roleId, dto);
    });

// -----------------------
// Delete Role provider
// -----------------------
final deleteRoleProvider = FutureProvider.family<void, String>((ref, roleId) async {
  final repo = ref.read(rolesRepositoryProvider);
  await repo.deleteRole(roleId);
});
/// 🔥 Role Permissions provider
final rolePermissionsProvider =
FutureProvider.family<List<PermissionDto>, String>((ref, roleId) async {
  final repo = ref.read(rolesRepositoryProvider);
  return repo.getRolePermissions(roleId);
});
/// get all permissions
final allPermissionsProvider = FutureProvider<List<PermissionDto>>((ref) async {
  final repo = ref.read(permissionsRepositoryProvider);
  return repo.getPermissions();
});
/// update role permissions
final updateRolePermissionsProvider =
FutureProvider.family<void, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(rolesRepositoryProvider);
  final String roleId = params['roleId'];
  final List<String> permissionIds = List<String>.from(params['permissionIds']);
  await repo.updateRolePermissions(roleId, permissionIds);
});
/// delete particular permission of a role
final removePermissionFromRoleProvider =
FutureProvider.family.autoDispose<void, Map<String, String>>((ref, params) async {
  final roleId = params['roleId']!;
  final permissionId = params['permissionId']!;

  final response = await ref.read(dioProvider).delete(
    '/role-permissions/$roleId/$permissionId',
  );

  if (response.statusCode != 200) {
    throw Exception("Failed to remove permission");
  }

  // ✅ Invalidate role permissions so UI refreshes automatically
  ref.invalidate(rolePermissionsProvider(roleId));
});
