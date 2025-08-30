class PermissionDto {
  final String id;
  final String name;
  final String resource;
  final String action;
  final String? description; // optional

  PermissionDto({
    required this.id,
    required this.name,
    required this.resource,
    required this.action,
    this.description,
  });

  factory PermissionDto.fromJson(Map<String, dynamic> json) {
    return PermissionDto(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      resource: json['resource'] as String? ?? '',
      action: json['action'] as String? ?? '',
      description: json['description'] as String?, // nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "resource": resource,
      "action": action,
      "description": description,
    };
  }
}
