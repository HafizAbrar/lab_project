import 'package:json_annotation/json_annotation.dart';

part 'update_user_dto.g.dart';

@JsonSerializable()
class UpdateUserDto {
  final String? email;
  final String? fullName;
  final String? roleId;
  final String? password;

  UpdateUserDto({
     this.email,
   this.fullName,
    this.roleId,
    this.password,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);
}
