import 'package:json_annotation/json_annotation.dart';

part 'create_role_dto.g.dart';

@JsonSerializable()
class CreateRoleDto {
  final String name;
  final String description;

  CreateRoleDto({required this.name, required this.description});

  factory CreateRoleDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRoleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoleDtoToJson(this);
}
