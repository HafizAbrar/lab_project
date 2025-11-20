class CreateServiceDto {
  final String name;
  final String description;

  CreateServiceDto({
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
  };
}
