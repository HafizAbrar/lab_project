// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_role_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateRoleDto _$CreateRoleDtoFromJson(Map<String, dynamic> json) =>
    CreateRoleDto(
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreateRoleDtoToJson(CreateRoleDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
