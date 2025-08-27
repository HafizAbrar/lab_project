// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    UpdateUserDto(
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      roleId: json['roleId'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'roleId': instance.roleId,
      'password': instance.password,
    };
