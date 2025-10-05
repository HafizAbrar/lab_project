import '../../data/models/create_employee_skill_dto.dart';
import '../../data/models/get_skills_of_an_employee_dto.dart';

abstract class EmployeeSkillsRepository {
  /// Create a new employee skill
  Future<void> createEmployeeSkill(CreateEmployeeSkillDto dto);

  /// Get all skills of a specific employee
  Future<List<EmployeeSkillDto>> getEmployeeSkills(String employeeId);

  /// Update a specific employee skill
  /// The DTO must contain the skill ID and employee ID internally
  Future<void> updateEmployeeSkill({
    required CreateEmployeeSkillDto dto,
  });

  /// Delete a specific employee skill
  Future<void> deleteEmployeeSkill({
    required String employeeId,
    required String skillId,
  });
}
