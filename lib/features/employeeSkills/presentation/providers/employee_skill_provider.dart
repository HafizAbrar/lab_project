import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab_app/features/roles/presentation/providers/roles_providers.dart';
import '../../data/models/create_employee_skill_dto.dart';
import '../../data/models/get_skills_of_an_employee_dto.dart';
import '../../data/sources/employee_skills_remote_source.dart';

// -------------------------------
// Remote source provider
// -------------------------------
final employeeSkillsRemoteSourceProvider = Provider<EmployeeSkillsRemoteSource>(
      (ref) => EmployeeSkillsRemoteSource(ref.read(dioProvider)),
);

// -------------------------------
// Create Employee Skill provider
// -------------------------------
final createEmployeeSkillProvider =
FutureProvider.family<void, CreateEmployeeSkillDto>((ref, dto) async {
  final remoteSource = ref.read(employeeSkillsRemoteSourceProvider);
  await remoteSource.createEmployeeSkill(dto);
});

// -------------------------------
// ✅ Update Employee Skill provider (fixed)
// -------------------------------
final updateEmployeeSkillProvider =
FutureProvider.family<void, Map<String, dynamic>>((ref, params) async {
  final remoteSource = ref.read(employeeSkillsRemoteSourceProvider);
  final dto = params['dto'] as CreateEmployeeSkillDto;
  await remoteSource.updateEmployeeSkill(
    dto,
  );
});

// -------------------------------
// Delete Employee Skill provider
// -------------------------------
final deleteEmployeeSkillProvider =
FutureProvider.family<void, Map<String, String>>((ref, params) async {
  final remoteSource = ref.read(employeeSkillsRemoteSourceProvider);
  await remoteSource.deleteEmployeeSkill(
    employeeId: params['employeeId']!,
    skillId: params['skillId']!,
  );
});

// -------------------------------
// Get all skills of an employee
// -------------------------------
final getEmployeeSkillsProvider =
FutureProvider.family<List<EmployeeSkillDto>, String>((ref, employeeId) async {
  final remoteSource = ref.read(employeeSkillsRemoteSourceProvider);
  return remoteSource.getEmployeeSkills(employeeId);
});
