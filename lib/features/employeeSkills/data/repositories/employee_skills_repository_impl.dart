import '../../domain/repositories/employee_skills_repository.dart';
import '../models/create_employee_skill_dto.dart';
import '../models/get_skills_of_an_employee_dto.dart';
import '../sources/employee_skills_remote_source.dart';

class EmployeeSkillsRepositoryImpl implements EmployeeSkillsRepository {
  final EmployeeSkillsRemoteSource remoteSource;

  EmployeeSkillsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createEmployeeSkill(CreateEmployeeSkillDto dto) {
    return remoteSource.createEmployeeSkill(dto);
  }

  @override
  Future<List<EmployeeSkillDto>> getEmployeeSkills(String employeeId) {
    return remoteSource.getEmployeeSkills(employeeId);
  }

  @override
  Future<void> updateEmployeeSkill({
    required CreateEmployeeSkillDto dto,
  }) {
    // ✅ Call the remote source with only the DTO
    return remoteSource.updateEmployeeSkill(dto);
  }

  @override
  Future<void> deleteEmployeeSkill({
    required String employeeId,
    required String skillId,
  }) {
    return remoteSource.deleteEmployeeSkill(
      employeeId: employeeId,
      skillId: skillId,
    );
  }
}
