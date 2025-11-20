// lib/features/technologies/data/models/create_technology_dto.dart

class CreateTechnologyDto {
  final String name;
  final String description;
  final String? category; // optional, e.g., "Frontend", "Backend", "Database"

  CreateTechnologyDto({
    required this.name,
    required this.description,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      if (category != null) 'category': category,
    };
  }
}
