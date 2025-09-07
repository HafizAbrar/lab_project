// lib/features/employees/data/models/employee_dto.dart
class EmployeeDto {
  final String id;
  final String email;
  final String fullName;
  final String createdAt;
  final String updatedAt;
  final String roleId;
  final String roleName;

  EmployeeDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.roleName,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    final role = json['role'] as Map<String, dynamic>? ?? {};
    return EmployeeDto(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      roleId: role['id'] ?? '',
      roleName: role['name'] ?? '',
    );
  }
}
