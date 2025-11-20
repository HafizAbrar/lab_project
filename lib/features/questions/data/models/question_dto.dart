class QuestionDto {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final List<String> tags;
  final bool isPublic;
  final int viewCount;
  final int answerCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuestionDto({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.tags,
    required this.isPublic,
    required this.viewCount,
    required this.answerCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) => QuestionDto(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    authorId: json['authorId'],
    tags: List<String>.from(json['tags']),
    isPublic: json['isPublic'] ?? true,
    viewCount: json['viewCount'] ?? 0,
    answerCount: json['answerCount'] ?? 0,
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}
