class CreateEmployeeSkillDto {
  final String? employeeId;
  final String? skillId;
  final int? proficiencyLevel;
  final int? yearsOfExperience;

  CreateEmployeeSkillDto({
     this.employeeId,
     this.skillId,
    this.proficiencyLevel,
    this.yearsOfExperience,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'skillId': skillId,
      if (proficiencyLevel != null) 'proficiencyLevel': proficiencyLevel,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
    };
  }

  factory CreateEmployeeSkillDto.fromJson(Map<String, dynamic> json) {
    return CreateEmployeeSkillDto(
      employeeId: json['employeeId'],
      skillId: json['skillId'],
      proficiencyLevel: json['proficiencyLevel'],
      yearsOfExperience: json['yearsOfExperience'],
    );
  }
}
