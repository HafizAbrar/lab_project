// lib/features/employee_skills/data/models/employee_skill_dto.dart
class EmployeeSkillDto {
  final String id;
  final String employeeId;
  final String skillId;
  final int proficiencyLevel;
  final int? yearsOfExperience;
  final String createdAt;
  final String updatedAt;
  final String? skillName;
  final String? category;

  EmployeeSkillDto({
    required this.id,
    required this.employeeId,
    required this.skillId,
    required this.proficiencyLevel,
    this.yearsOfExperience,
    required this.createdAt,
    required this.updatedAt,
    this.skillName,
    this.category,
  });

  factory EmployeeSkillDto.fromJson(Map<String, dynamic> json) {
    return EmployeeSkillDto(
      id: json['id'] ?? '',
      employeeId: json['employeeId'] ?? '',
      skillId: json['skillId'] ?? '',
      proficiencyLevel: json['proficiencyLevel'] ?? 0,
      yearsOfExperience: json['yearsOfExperience'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      skillName: json['skill']?['name'],
      category: json['skill']?['category'],
    );
  }
}
