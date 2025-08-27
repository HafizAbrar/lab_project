import 'package:json_annotation/json_annotation.dart';

part 'create_role_dto.g.dart';

@JsonSerializable()
class CreateRoleDto {
  final String name;

  CreateRoleDto({required this.name});

  factory CreateRoleDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRoleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoleDtoToJson(this);
}
