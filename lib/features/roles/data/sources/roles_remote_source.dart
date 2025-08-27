import 'package:dio/dio.dart';

import '../models/role_dto.dart';
import '../models/create_role_dto.dart';
import '../models/update_role_dto.dart';

class RolesRemoteSource {
  final Dio _dio;

  RolesRemoteSource(this._dio);
//FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<List<RoleDto>> getRoles() async {
    final response = await _dio.get('/roles');

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;

    final rolesJson = data['data'] as List<dynamic>? ?? [];

    return rolesJson.map((json) => RoleDto.fromJson(json)).toList();
  }

  Future<RoleDto> createRole(CreateRoleDto dto) async {
    final response = await _dio.post('/roles', data: dto.toJson());
    return RoleDto.fromJson(response.data['data']);
  }

  Future<RoleDto> updateRole(String id, UpdateRoleDto dto) async {
    final data = dto.toJson()..removeWhere((k, v) => v == null);
    final response = await _dio.patch('/roles/$id', data: data);
    return RoleDto.fromJson(response.data['data']);
  }

  Future<void> deleteRole(String id) async {
    await _dio.delete('/roles/$id');
  }
}
