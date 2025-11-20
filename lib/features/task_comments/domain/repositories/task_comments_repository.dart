import '../../data/models/create_task_comment_dto.dart';
import '../../data/models/task_comment_dto.dart';

abstract class TaskCommentsRepository {
  Future<void> createTaskComment(CreateTaskCommentDto dto);
  Future<void> updateTaskComment(String commentId, CreateTaskCommentDto dto);
  Future<void> deleteTaskComment(String commentId);
  Future<List<TaskCommentDto>> getCommentsByTaskId(String taskId);
  Future<TaskCommentDto> getTaskCommentById(String id);
}
