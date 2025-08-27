import 'package:json_annotation/json_annotation.dart';

import '../../../roles/data/models/role_dto.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final String? password;
  final String id;
  final String email;
  final RoleDto? role;
  @JsonKey(name: 'fullName')
  final String fullName;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  UserDto({
    this.password,
    required this.role,
    required this.id,
    required this.email,
    required this.fullName,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
