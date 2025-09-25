// lib/data/models/permission_dto.dart
class PermissionDto {
  final String id;
  final String name;
  final String description;

  PermissionDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) {
    return PermissionDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
    );
  }
}
