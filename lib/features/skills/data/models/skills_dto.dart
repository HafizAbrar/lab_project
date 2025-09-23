class SkillDto {
  final String id;
  final String name;
  final String? description;
  final String? category;

  SkillDto({
    required this.id,
    required this.name,
    this.description,
    this.category,
  });

  factory SkillDto.fromJson(Map<String, dynamic> json) {
    return SkillDto(
      id: json['id'].toString(),        // toString() for safety
      name: json['name'] ?? "",
      description: json['description'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
    };
  }
}
