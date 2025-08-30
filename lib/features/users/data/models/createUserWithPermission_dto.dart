class CreateUserWithPermissionsDto {
  final String email;
  final String password;
  final String fullName;
  final String roleId;
  final List<String> permissionIds;

  CreateUserWithPermissionsDto({
    required this.email,
    required this.password,
    required this.fullName,
    required this.roleId,
    required this.permissionIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "fullName": fullName,
      "roleId": roleId,
      "permissionIds": permissionIds,
    };
  }
}
