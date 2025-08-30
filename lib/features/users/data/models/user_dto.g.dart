// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  password: json['password'] as String?,
  role:
      json['role'] == null
          ? null
          : RoleDto.fromJson(json['role'] as Map<String, dynamic>),
  id: json['id'] as String,
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'password': instance.password,
  'id': instance.id,
  'email': instance.email,
  'role': instance.role,
  'fullName': instance.fullName,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
