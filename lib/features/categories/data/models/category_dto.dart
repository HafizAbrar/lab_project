// lib/data/models/category_dto.dart
class CategoryDto {
  final String id;
  final String name;
  final String slug;
  final String? description;

  CategoryDto({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
    );
  }
}
