// lib/data/models/create_category_dto.dart
class CreateCategoryDto {
  final String name;
  final String slug;
  final String? description;

  CreateCategoryDto({
    required this.name,
    required this.slug,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'slug': slug,
    if (description != null) 'description': description,
  };
}
