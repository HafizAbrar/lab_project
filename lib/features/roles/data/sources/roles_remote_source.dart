import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../permissions/data/modals/permission_dto.dart';
import '../models/role_dto.dart';
import '../models/create_role_dto.dart';
import '../models/update_role_dto.dart';

class RolesRemoteSource {
  final Dio _dio;
  RolesRemoteSource(this._dio);

  Future<List<RoleDto>> getRoles() async {
    final response = await _dio.get('/roles');
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    final rolesJson = data['data'] as List<dynamic>? ?? [];
    return rolesJson.map((json) => RoleDto.fromJson(json)).toList();
  }

  Future<RoleDto> createRole(CreateRoleDto dto) async {
    final response = await _dio.post(
      '/roles',
      data: jsonEncode(dto.toJson()),
    );
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return RoleDto.fromJson(data['data']);
  }

  Future<RoleDto> updateRole(String roleId, UpdateRoleDto dto) async {
    final response = await _dio.patch(
      "/roles/$roleId",
      data: jsonEncode(dto.toJson()),
    );
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return RoleDto.fromJson(data['data']);
  }

  Future<void> deleteRole(String id) async {
    await _dio.delete('/roles/$id');
  }
  /// 🔥 Update permissions of a particular role
  Future<void> updateRolePermissions(String roleId, List<String> permissionIds) async {
    final response = await _dio.post(
      "/role-permissions/$roleId",
      data: jsonEncode({"permissionIds": permissionIds}),
    );
    // Optionally check response["success"] etc.
  }

  /// 🔥 Get permissions of a particular role
  Future<List<PermissionDto>> getRolePermissions(String roleId) async {
    final response = await _dio.get('/role-permissions/$roleId');
    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    final permissionsJson = data['data'] as List<dynamic>? ?? [];
    return permissionsJson.map((p) => PermissionDto.fromJson(p)).toList();
  }
}
