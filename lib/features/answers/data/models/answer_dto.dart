class AnswerDto {
  final String id;
  final String questionId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final bool isAccepted;
  final int upvotes;
  final int downvotes;

  AnswerDto({
    required this.id,
    required this.questionId,
    required this.userId,
    required this.content,
    required this.createdAt,
    required this.isAccepted,
    required this.upvotes,
    required this.downvotes,
  });

  factory AnswerDto.fromJson(Map<String, dynamic> json) {
    return AnswerDto(
      id: json['id'],
      questionId: json['questionId'],
      userId: json['userId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      isAccepted: json['isAccepted'] ?? false,
      upvotes: json['upvotes'] ?? 0,
      downvotes: json['downvotes'] ?? 0,
    );
  }
}
