class CreateAnswerDto {
  final String questionId;
  final String userId;
  final String content;

  CreateAnswerDto({
    required this.questionId,
    required this.userId,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'userId': userId,
    'content': content,
  };
}
