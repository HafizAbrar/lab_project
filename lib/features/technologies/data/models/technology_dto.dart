// lib/features/technologies/data/models/technology_dto.dart

class TechnologyDto {
  final String id;
  final String name;
  final String description;
  final String? category;
  final DateTime createdAt;
  final DateTime updatedAt;

  TechnologyDto({
    required this.id,
    required this.name,
    required this.description,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TechnologyDto.fromJson(Map<String, dynamic> json) {
    return TechnologyDto(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      if (category != null) 'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
