import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@JsonSerializable()
class RoleDto {
  final String id;
  final String name;
  final String description;

  RoleDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

