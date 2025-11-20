class CreateProjectMemberDto {
  final String projectId;
  final String employeeId;
  final String role;
  final String joinedDate;

  CreateProjectMemberDto({
    required this.projectId,
    required this.employeeId,
    required this.role,
    required this.joinedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'employeeId': employeeId,
      'role': role,
      'joinedDate': joinedDate,
    };
  }
}
