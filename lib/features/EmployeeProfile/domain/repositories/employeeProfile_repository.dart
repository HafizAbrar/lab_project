import 'dart:io';

import '../../data/models/create_employee_profile_dto.dart';
import '../../data/models/update_employee_profile_dto.dart';
import '../../data/models/employee_profile_dto.dart';
import '../../data/models/employees_dto.dart';

abstract class EmployeeProfilesRepository {
  /// Get all employees (for dropdowns etc.)
  Future<List<EmployeeDto>> getEmployees();

  /// Create a new employee profile
  Future<EmployeeProfileDto> createEmployeeProfile(
      CreateEmployeeProfileDto dto, {
        File? file,
      });

  /// Get all employee profiles
  Future<List<EmployeeProfileDto>> getEmployeeProfiles();

  /// Delete employee profile
  Future<void> deleteEmployeeProfile(String id);

  /// Update employee profile (fields only, no image)
  Future<EmployeeProfileDto> updateEmployeeProfile(
      String profileId,
      UpdateEmployeeProfileDto dto,
      );

  /// Update only profile image
  Future<EmployeeProfileDto> updateEmployeeProfileImage(
      String profileId,
      File file,
      );
}
