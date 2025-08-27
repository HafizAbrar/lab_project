import 'package:json_annotation/json_annotation.dart';

part 'create_user_dto.g.dart';

/// Matches backend CreateUserDto (email, password, fullName).
/// We omit roleId for now since you don't need roles yet.
@JsonSerializable()
class CreateUserDto {
  final String email;
  final String password;
  @JsonKey(name: 'fullName')
  final String fullName;
  final String roleId;

  CreateUserDto({
    required this.email,
    required this.password,
    required this.fullName,
    required this.roleId,
  });

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);
}
