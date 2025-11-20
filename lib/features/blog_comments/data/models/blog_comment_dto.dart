class BlogCommentDto {
  final String id;
  final String postId;
  final String authorId;
  final String content;
  final String? parentCommentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isApproved;

  BlogCommentDto({
    required this.id,
    required this.postId,
    required this.authorId,
    required this.content,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    required this.isApproved,
  });

  factory BlogCommentDto.fromJson(Map<String, dynamic> json) => BlogCommentDto(
    id: json['id'],
    postId: json['postId'],
    authorId: json['authorId'],
    content: json['content'],
    parentCommentId: json['parentCommentId'],
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
    isApproved: json['isApproved'] ?? false,
  );
}
