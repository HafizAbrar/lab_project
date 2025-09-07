import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/network/dio_client.dart';
import '../../data/models/employees_dto.dart';
import '../../data/models/employee_profile_dto.dart';
import '../../data/models/create_employee_profile_dto.dart';
import '../../data/models/update_employee_profile_dto.dart';
import '../../data/repositories/employeeProfile_repository_impl.dart';
import '../../data/sources/employeeProfile_remote_source.dart';
import '../../domain/repositories/employeeProfile_repository.dart';

/// 🔐 Secure storage provider
final employeeSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// 🌐 Dio client provider
final employeeDioProvider = Provider<Dio>((ref) {
  final storage = ref.read(employeeSecureStorageProvider);
  final client = DioClient(storage);
  return client.build();
});

/// 📡 Remote source provider
final employeeRemoteSourceProvider =
Provider<EmployeeProfilesRemoteSource>((ref) {
  final dio = ref.read(employeeDioProvider);
  return EmployeeProfilesRemoteSource(dio);
});

/// 🏗 Repository provider
final employeeRepositoryProvider =
Provider<EmployeeProfilesRepository>((ref) {
  final remoteSource = ref.read(employeeRemoteSourceProvider);
  return EmployeeProfilesRepositoryImpl(remoteSource);
});

/// 👥 Employees (users with role=employee)
final employeesListProvider = FutureProvider<List<EmployeeDto>>((ref) async {
  final repo = ref.read(employeeRepositoryProvider);
  return repo.getEmployees();
});

/// 📋 Employee profiles list
final employeeProfilesProvider =
FutureProvider<List<EmployeeProfileDto>>((ref) async {
  final repo = ref.read(employeeRepositoryProvider);
  return repo.getEmployeeProfiles();
});

/// ➕ Create new employee profile params holder
class CreateEmployeeProfileParams {
  final CreateEmployeeProfileDto dto;
  final File? file;
  CreateEmployeeProfileParams(this.dto, this.file);
}

/// ➕ Create new employee profile provider
final createEmployeeProfileProvider = FutureProvider.family<
    EmployeeProfileDto, CreateEmployeeProfileParams>((ref, params) async {
  final repo = ref.read(employeeRepositoryProvider);
  return repo.createEmployeeProfile(params.dto, file: params.file);
});
// 🔹 Update Employee Profile Provider
final updateEmployeeProfileProvider = FutureProvider.family
<EmployeeProfileDto, Map<String, dynamic>>((ref, params) async {
  final repo = ref.read(employeeRepositoryProvider);
  final profileId = params['profileId'] as String;
  final dto = params['dto'] as UpdateEmployeeProfileDto;
  final file = params['file'] as File?;

  return repo.updateEmployeeProfile(profileId, dto, file: file);
});
/// delete employee profile
final deleteEmployeeProfileProvider = FutureProvider.family<void, String>((ref, id) async {
  final repo = ref.read(employeeRepositoryProvider);
  await repo.deleteEmployeeProfile(id); // implement this in repo
});
