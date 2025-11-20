class TaskCommentDto {
  final String id;
  final String taskId;
  final String commentText;
  final String createdBy;
  final String createdAt;

  TaskCommentDto({
    required this.id,
    required this.taskId,
    required this.commentText,
    required this.createdBy,
    required this.createdAt,
  });

  factory TaskCommentDto.fromJson(Map<String, dynamic> json) {
    return TaskCommentDto(
      id: json['id'],
      taskId: json['taskId'],
      commentText: json['commentText'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
    );
  }
}
