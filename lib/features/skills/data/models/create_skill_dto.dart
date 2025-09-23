class CreateSkillDto {
  final String name;
  final String? description;
  final String? category;

  CreateSkillDto({
    required this.name,
    this.description,
    this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category,
    };
  }
}
