import 'dart:io';

import '../../domain/repositories/employeeProfile_repository.dart';
import '../models/create_employee_profile_dto.dart';
import '../models/employee_profile_dto.dart';
import '../models/employees_dto.dart';
import '../models/update_employee_profile_dto.dart';
import '../sources/employeeProfile_remote_source.dart';

class EmployeeProfilesRepositoryImpl implements EmployeeProfilesRepository {
  final EmployeeProfilesRemoteSource _remoteSource;
  EmployeeProfilesRepositoryImpl(this._remoteSource);

  @override
  Future<List<EmployeeDto>> getEmployees() => _remoteSource.getEmployees();

  @override
  Future<EmployeeProfileDto> createEmployeeProfile(
      CreateEmployeeProfileDto dto, {
        File? file,
      }) {
    return _remoteSource.createEmployeeProfile(dto, file: file);
  }

  @override
  Future<List<EmployeeProfileDto>> getEmployeeProfiles() =>
      _remoteSource.getEmployeeProfiles();

  @override
  Future<void> deleteEmployeeProfile(String id) =>
      _remoteSource.deleteEmployeeProfile(id);

  /// 🔹 Update employee profile details (without image)
  @override
  Future<EmployeeProfileDto> updateEmployeeProfile(
      String profileId,
      UpdateEmployeeProfileDto dto,
      ) {
    return _remoteSource.updateEmployeeProfile(profileId, dto);
  }
  /// Get one employee profile by ID
  @override
  Future<EmployeeProfileDto> getEmployeeProfile(String id) {
    return _remoteSource.getEmployeeProfile(id);
  }

  /// 🔹 Update only profile image
  @override
  Future<EmployeeProfileDto> updateEmployeeProfileImage(
      String profileId,
      File file,
      ) {
    return _remoteSource.updateEmployeeProfileImage(profileId, file);
  }
}
