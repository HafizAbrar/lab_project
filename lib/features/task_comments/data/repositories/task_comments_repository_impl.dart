import '../../domain/repositories/task_comments_repository.dart';
import '../models/create_task_comment_dto.dart';
import '../models/task_comment_dto.dart';
import '../sources/task_comment_remote_source.dart';

class TaskCommentsRepositoryImpl implements TaskCommentsRepository {
  final TaskCommentRemoteSource remoteSource;

  TaskCommentsRepositoryImpl(this.remoteSource);

  @override
  Future<void> createTaskComment(CreateTaskCommentDto dto) {
    return remoteSource.createTaskComment(dto);
  }

  @override
  Future<void> updateTaskComment(String commentId, CreateTaskCommentDto dto) {
    return remoteSource.updateTaskComment(commentId, dto);
  }

  @override
  Future<void> deleteTaskComment(String commentId) {
    return remoteSource.deleteTaskComment(commentId);
  }

  @override
  Future<List<TaskCommentDto>> getCommentsByTaskId(String taskId) {
    return remoteSource.getCommentsByTaskId(taskId);
  }

  @override
  Future<TaskCommentDto> getTaskCommentById(String id) {
    return remoteSource.getTaskCommentById(id);
  }
}
