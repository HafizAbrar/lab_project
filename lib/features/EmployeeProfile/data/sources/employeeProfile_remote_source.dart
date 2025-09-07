import 'dart:io';
import 'package:dio/dio.dart';

import '../models/create_employee_profile_dto.dart';
import '../models/employee_profile_dto.dart';
import '../models/employees_dto.dart';
import '../models/update_employee_profile_dto.dart';

class EmployeeProfilesRemoteSource {
  final Dio _dio;
  EmployeeProfilesRemoteSource(this._dio);

  Future<List<EmployeeDto>> getEmployees() async {
    final response = await _dio.get('/users');

    final data = response.data as Map<String, dynamic>;
    final usersJson = data['data'] as List<dynamic>? ?? [];

    // filter users where role.name == "employee"
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
    // Always create a new FormData
    final formData = FormData.fromMap({
      ...dto.toJson(),
      if (file != null)
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path
              .split("/")
              .last,
        ),
    });

    final response = await _dio.post('/employee-profiles', data: formData);

    if (response.data == null) {
      throw Exception("No data returned from server");
    }

    final responseJson = response.data as Map<String, dynamic>;

// Use null-aware operator here
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
  // 🔹 Update Employee Profile
  Future<EmployeeProfileDto> updateEmployeeProfile(
      String profileId,
      UpdateEmployeeProfileDto dto, {
        File? file,
      }) async {
    try {
      final formData = FormData.fromMap({
        ...dto.toJson(),
        if (file != null)
          "profileImage": await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
      });

      final response = await _dio.patch(
        '/employee-profiles/$profileId',
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      return EmployeeProfileDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
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
