class ProjectMemberDto {
  final String id;
  final String projectId;
  final String employeeId;
  final String role;
  final String joinedDate;

  ProjectMemberDto({
    required this.id,
    required this.projectId,
    required this.employeeId,
    required this.role,
    required this.joinedDate,
  });

  factory ProjectMemberDto.fromJson(Map<String, dynamic> json) {
    return ProjectMemberDto(
      id: json['id'],
      projectId: json['projectId'],
      employeeId: json['employeeId'],
      role: json['role'],
      joinedDate: json['joinedDate'],
    );
  }
}
