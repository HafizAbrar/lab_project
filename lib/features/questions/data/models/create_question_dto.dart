class CreateQuestionDto {
  final String title;
  final String description;
  final String authorId;
  final List<String> tags;
  final bool isPublic;

  CreateQuestionDto({
    required this.title,
    required this.description,
    required this.authorId,
    required this.tags,
    required this.isPublic,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'authorId': authorId,
    'tags': tags,
    'isPublic': isPublic,
  };
}
