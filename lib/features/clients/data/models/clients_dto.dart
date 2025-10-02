// lib/features/clients/data/models/clients_dto.dart
class ClientDto {
  final String id;
  final String email;
  final String fullName;
  final String createdAt;
  final String updatedAt;
  final String roleId;
  final String roleName;

  ClientDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.roleName,
  });

  factory ClientDto.fromJson(Map<String, dynamic> json) {
    final role = json['role'] as Map<String, dynamic>? ?? {};
    return ClientDto(
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
