class CreateBlogPostDto {
  final String title;
  final String content;
  final String authorId;
  final String category;
  final List<String> tags;
  final String coverImageUrl;
  final bool isPublished;

  CreateBlogPostDto({
    required this.title,
    required this.content,
    required this.authorId,
    required this.category,
    required this.tags,
    required this.coverImageUrl,
    required this.isPublished,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'authorId': authorId,
    'category': category,
    'tags': tags,
    'coverImageUrl': coverImageUrl,
    'isPublished': isPublished,
  };
}
