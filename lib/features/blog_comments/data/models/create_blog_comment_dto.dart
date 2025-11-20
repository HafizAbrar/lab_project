class CreateBlogCommentDto {
  final String postId;
  final String authorId;
  final String content;
  final String? parentCommentId; // for threaded replies

  CreateBlogCommentDto({
    required this.postId,
    required this.authorId,
    required this.content,
    this.parentCommentId,
  });

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'authorId': authorId,
    'content': content,
    'parentCommentId': parentCommentId,
  };
}
