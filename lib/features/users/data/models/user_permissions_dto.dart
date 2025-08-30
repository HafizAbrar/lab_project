import '../../../permissions/data/modals/permission_dto.dart';

class UserPermissionsDto {
  final String? userId;
  final List<PermissionDto> permissions;

  UserPermissionsDto({
    this.userId,
    required this.permissions,
  });

  factory UserPermissionsDto.fromJson(dynamic json) {
    // Case 1: If backend returns a map with userId + permissions
    if (json is Map<String, dynamic>) {
      final perms = json['permissions'] as List? ?? [];
      return UserPermissionsDto(
        userId: json['userId'] as String?,
        permissions: perms.map((perm) {
          return PermissionDto.fromJson(perm as Map<String, dynamic>);
        }).toList(),
      );
    }

    // Case 2: If backend directly returns a list of permissions
    else if (json is List) {
      return UserPermissionsDto(
        userId: null,
        permissions: json.map((perm) {
          return PermissionDto.fromJson(perm as Map<String, dynamic>);
        }).toList(),
      );
    }

    throw Exception("Invalid JSON format for UserPermissionsDto");
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "permissions": permissions.map((e) => e.toJson()).toList(),
    };
  }
}
