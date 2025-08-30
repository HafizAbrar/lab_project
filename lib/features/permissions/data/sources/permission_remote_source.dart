import 'package:dio/dio.dart';

import '../modals/permission_dto.dart';


class PermissionsRemoteSource {
  final Dio _dio;

  PermissionsRemoteSource(this._dio);

  Future<List<PermissionDto>> getPermissions() async {
    try {
      print('Fetching permissions from API...');
      final res = await _dio.get('/permissions');
      print('Permissions API response: ${res.data}');

      dynamic data;
      if (res.data is Map<String, dynamic>) {
        data = res.data['data'];
      } else {
        data = res.data;
      }

      // ✅ Ensure it's a list
      if (data is List) {
        return data
            .map((j) => PermissionDto.fromJson(j as Map<String, dynamic>))
            .toList();
      } else if (data is Map<String, dynamic>) {
        // API sent a single object instead of a list
        return [PermissionDto.fromJson(data)];
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching permissions: $e');
      rethrow;
    }
  }
}

