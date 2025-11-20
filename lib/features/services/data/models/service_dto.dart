class ServiceDto {
  final String id;
  final String name;
  final String description;

  ServiceDto({
    required this.id,
    required this.name,
    required this.description,
  });

  factory ServiceDto.fromJson(Map<String, dynamic> json) {
    return ServiceDto(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
  };
}
