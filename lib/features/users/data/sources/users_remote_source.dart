import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../permissions/data/modals/permission_dto.dart';
import '../models/createUserWithPermission_dto.dart';
import '../models/updatePermissions_dto.dart';
import '../models/update_user_dto.dart';
import '../models/user_dto.dart';
import '../models/create_user_dto.dart';
import '../models/user_permissions_dto.dart';

class UsersRemoteSource {
  UsersRemoteSource(this._dio);
  final Dio _dio;

  // 🔑 Secure storage instance
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// GET /users  -> ServiceResponse<User[]>
  Future<List<UserDto>> findAll() async {
    try {
      print('Fetching users from API...');
      final res = await _dio.get('/users');
      print('Users API response: ${res.data}');

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      final list = (data as List?) ?? const [];
      final users =
      list.map((j) => UserDto.fromJson(j as Map<String, dynamic>)).toList();

      print('Parsed ${users.length} users');
      return users;
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }

  /// POST /users  -> ServiceResponse<User>
  Future<UserDto> createUser(CreateUserDto dto) async {
    try {
      print('Creating user: ${dto.toJson()}');
      final res = await _dio.post('/users', data: dto.toJson());
      print('Create user response: ${res.data}');

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      return UserDto.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

  /// DELETE /users/{id}
  Future<void> deleteUser(String userId) async {
    await _dio.delete('/users/$userId');
  }

  /// PATCH /users/{id}  -> ServiceResponse<User>
  Future<UserDto> updateUser(String userId, UpdateUserDto dto) async {
    final data = dto.toJson()..removeWhere((key, value) => value == null);

    // ✅ Read token from secure storage
    final token = await _storage.read(key: 'access_token');

    final response = await _dio.patch(
      '/users/$userId',
      data: data,
      options: Options(
        headers: {
          'Accept': 'application/json',
          if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
      ),
    );

    return UserDto.fromJson(response.data['data']);
  }

  /// ✅ GET /users/{id}/permissions -> ServiceResponse<UserPermissionsDto>
  Future<UserPermissionsDto> getUserPermissions(String userId) async {
    try {
      final token = await _storage.read(key: 'access_token');
      final res = await _dio.get(
        '/users/$userId/permissions',
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      return UserPermissionsDto.fromJson(data);
    } catch (e) {
      print('Error fetching user permissions: $e');
      rethrow;
    }
  }
  /// POST /users/with-permissions  -> ServiceResponse<User>
  Future<UserDto> createUserWithPermissions(CreateUserWithPermissionsDto dto) async {
    try {
      print('Creating user with permissions: ${dto.toJson()}');
      final res = await _dio.post('/users/with-permissions', data: dto.toJson());
      print('Create user with permissions response: ${res.data}');

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      return UserDto.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      print('Error creating user with permissions: $e');
      rethrow;
    }
  }
  Future<void> assignPermissions(String userId, UpdatePermissionDto dto) async {
    await _dio.post(
      "/users/$userId/permissions",
      data: dto.toJson(),
    );
  }
  Future<void> updateUserPermissions(String userId, UpdatePermissionDto dto) async {
    await _dio.post(
      '/users/$userId/permissions',
      data: dto.toJson(),
    );
  }
  /// ✅ GET /permissions  -> ServiceResponse<Permission[]>
  Future<List<PermissionDto>> getAllPermissions() async {
    try {
      print('Fetching permissions from API...');
      final token = await _storage.read(key: 'access_token');

      final res = await _dio.get(
        '/permissions',
        options: Options(
          headers: {
            'Accept': 'application/json',
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Permissions API response: ${res.data}');

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      final list = (data as List?) ?? const [];
      return list
          .map((e) => PermissionDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching permissions: $e');
      rethrow;
    }
  }
}

