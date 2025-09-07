import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/role_dto.dart';
import '../models/create_role_dto.dart';
import '../models/update_role_dto.dart';

class RolesRemoteSource {
  final Dio _dio;

  RolesRemoteSource(this._dio);
  //get all roles
  Future<List<RoleDto>> getRoles() async {
    final response = await _dio.get('/roles');

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;

    final rolesJson = data['data'] as List<dynamic>? ?? [];

    return rolesJson.map((json) => RoleDto.fromJson(json)).toList();
  }
//create role
  Future<RoleDto> createRole(CreateRoleDto dto) async {
    final response = await _dio.post(
      '/roles',
      data: jsonEncode(dto.toJson()), // ensure proper JSON string
    );
    return RoleDto.fromJson(response.data['data']);
  }

// Update role
  Future<RoleDto> updateRole(String roleId, UpdateRoleDto dto) async {
    final response = await _dio.patch(
      "/roles/$roleId",
      data: dto.toJson(),
    );
    return RoleDto.fromJson(response.data);
  }
//delete role
  Future<void> deleteRole(String id) async {
    await _dio.delete('/roles/$id');
  }
}
