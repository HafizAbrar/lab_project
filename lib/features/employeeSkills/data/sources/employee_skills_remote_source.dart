import 'package:dio/dio.dart';
import '../models/create_employee_skill_dto.dart';
import '../models/get_skills_of_an_employee_dto.dart';

class EmployeeSkillsRemoteSource {
  final Dio _dio;

  EmployeeSkillsRemoteSource(this._dio);

  // -------------------------------
  // Create a new employee skill
  // -------------------------------
  Future<void> createEmployeeSkill(CreateEmployeeSkillDto dto) async {
    try {
      await _dio.post(
        '/employee-skills',
        data: dto.toJson(),
      );
    } on DioException catch (e) {
      throw Exception(
        'Failed to create employee skill: ${e.response?.data ?? e.message}',
      );
    }
  }

  // -------------------------------
  // Update a specific employee skill
  // -------------------------------
  Future<void> updateEmployeeSkill(CreateEmployeeSkillDto dto) async {
    if (dto.skillId == null || dto.employeeId == null) {
      throw Exception('Skill ID and Employee ID are required in the DTO.');
    }

    try {
      await _dio.patch(
        '/employee-skills/${dto.employeeId}/${dto.skillId}',
        data: {
          'proficiencyLevel': dto.proficiencyLevel,
          'yearsOfExperience': dto.yearsOfExperience,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        'Failed to update employee skill: ${e.response?.data ?? e.message}',
      );
    }
  }

  // -------------------------------
  // Delete a specific employee skill
  // -------------------------------
  Future<void> deleteEmployeeSkill({
    required String employeeId,
    required String skillId,
  }) async {
    try {
      await _dio.delete('/employee-skills/$employeeId/$skillId');
    } on DioException catch (e) {
      throw Exception(
        'Failed to delete employee skill: ${e.response?.data ?? e.message}',
      );
    }
  }

  // -------------------------------
  // Get all skills of an employee
  // -------------------------------
  Future<List<EmployeeSkillDto>> getEmployeeSkills(String employeeId) async {
    try {
      final response = await _dio.get('/employee-skills/employee/$employeeId');

      final data = response.data;
      List<dynamic> skillsList = [];

      if (data is List) {
        skillsList = data;
      } else if (data is Map<String, dynamic>) {
        if (data.containsKey('data') && data['data'] is List) {
          skillsList = data['data'];
        } else if (data.containsKey('skills') && data['skills'] is List) {
          skillsList = data['skills'];
        } else if (data.containsKey('result') && data['result'] is List) {
          skillsList = data['result'];
        } else if (data.values.any((v) => v is List)) {
          skillsList = data.values.firstWhere((v) => v is List) as List;
        } else {
          throw Exception('Unexpected response shape: $data');
        }
      } else {
        throw Exception('Invalid response type: ${data.runtimeType}');
      }

      return skillsList
          .map((json) => EmployeeSkillDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch employee skills: ${e.response?.data ?? e.message}',
      );
    }
  }
}
