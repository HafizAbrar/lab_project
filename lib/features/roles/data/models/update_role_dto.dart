import 'package:json_annotation/json_annotation.dart';

part 'update_role_dto.g.dart';

@JsonSerializable()
class UpdateRoleDto {
  final String name;
  final String description;

  UpdateRoleDto({required this.name, required this.description});

  factory UpdateRoleDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoleDtoToJson(this);
}
