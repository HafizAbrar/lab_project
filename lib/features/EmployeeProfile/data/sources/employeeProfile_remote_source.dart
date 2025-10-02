import 'dart:io';
import 'package:dio/dio.dart';

import '../models/create_employee_profile_dto.dart';
import '../models/employee_profile_dto.dart';
import '../models/employees_dto.dart';
import '../models/update_employee_profile_dto.dart';

class EmployeeProfilesRemoteSource {
  final Dio _dio;
  EmployeeProfilesRemoteSource(this._dio);

  /// Get all users and filter employees
  Future<List<EmployeeDto>> getEmployees() async {
    final response = await _dio.get('/users');

    final data = response.data as Map<String, dynamic>;
    final usersJson = data['data'] as List<dynamic>? ?? [];

    final employees = usersJson.where((u) {
      final role = u['role'] as Map<String, dynamic>? ?? {};
      return role['name'] == 'employee';
    }).toList();

    return employees.map((json) => EmployeeDto.fromJson(json)).toList();
  }

  /// Create a new employee profile
  Future<EmployeeProfileDto> createEmployeeProfile(
      CreateEmployeeProfileDto dto, {
        File? file,
      }) async {
    final formData = FormData.fromMap({
      ...dto.toJson(),
      if (file != null)
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split("/").last,
        ),
    });

    final response = await _dio.post('/employee-profiles', data: formData);

    if (response.data == null) {
      throw Exception("No data returned from server");
    }

    final responseJson = response.data as Map<String, dynamic>;

    final dataMap = responseJson['data'] != null
        ? responseJson['data'] as Map<String, dynamic>
        : <String, dynamic>{
      "id": "",
      "userId": dto.userId,
      "hireDate": dto.hireDate,
      "jobTitle": dto.jobTitle,
      "department": dto.department,
      "status": dto.status,
      "profileImage": null,
      "user": null,
    };

    return EmployeeProfileDto.fromJson(dataMap);
  }

  /// Get all employee profiles
  Future<List<EmployeeProfileDto>> getEmployeeProfiles() async {
    final response = await _dio.get('/employee-profiles');

    final json = response.data as Map<String, dynamic>;
    final profiles = json['data'] as List<dynamic>? ?? [];

    return profiles.map((e) => EmployeeProfileDto.fromJson(e)).toList();
  }

  /// 🔹 Update only employee profile image
  Future<EmployeeProfileDto> updateEmployeeProfileImage(
      String profileId, File file) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final response = await _dio.patch(
      '/employee-profiles/$profileId/image',
      data: formData,
      options: Options(
        headers: {"Content-Type": "multipart/form-data"},
      ),
    );

    final data = response.data['data'] as Map<String, dynamic>;
    return EmployeeProfileDto.fromJson(data);
  }

  /// 🔹 Update employee profile details (jobTitle, department, etc.)
  Future<EmployeeProfileDto> updateEmployeeProfile(
      String profileId,
      UpdateEmployeeProfileDto dto,
      ) async {
    try {
      final response = await _dio.patch(
        '/employee-profiles/$profileId',
        data: dto.toJson(),
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      final data = response.data['data'] as Map<String, dynamic>;
      return EmployeeProfileDto.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }
  /// Get a single employee profile by ID
  Future<EmployeeProfileDto> getEmployeeProfile(String id) async {
    final response = await _dio.get('/employee-profiles/$id');

    final json = response.data as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;

    return EmployeeProfileDto.fromJson(data);
  }

  /// Delete employee profile by ID
  Future<void> deleteEmployeeProfile(String id) async {
    try {
      await _dio.delete('/employee-profiles/$id');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to delete profile');
    }
  }
}
