class CreateTaskCommentDto {
  final String taskId;
  final String commentText;
  final String createdBy;

  CreateTaskCommentDto({
    required this.taskId,
    required this.commentText,
    required this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'commentText': commentText,
      'createdBy': createdBy,
    };
  }
}
