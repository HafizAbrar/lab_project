class BlogPostDto {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String category;
  final List<String> tags;
  final String coverImageUrl;
  final bool isPublished;
  final int viewsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogPostDto({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.category,
    required this.tags,
    required this.coverImageUrl,
    required this.isPublished,
    required this.viewsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogPostDto.fromJson(Map<String, dynamic> json) => BlogPostDto(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    authorId: json['authorId'],
    category: json['category'],
    tags: List<String>.from(json['tags']),
    coverImageUrl: json['coverImageUrl'],
    isPublished: json['isPublished'],
    viewsCount: json['viewsCount'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}
